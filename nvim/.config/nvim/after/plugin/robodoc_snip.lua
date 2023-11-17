local ls = require "luasnip"
local s, i, t, f, d, sn, isn = ls.s, ls.insert_node, ls.text_node, ls.function_node, ls.dynamic_node, ls.sn, ls.indent_snippet_node
local fmt = require("luasnip.extras.fmt").fmt

-- some local variables that we use to store some information about the file we want to document
local name = nil
local module = false
local subroutine = false
local parameters = {}


-- treesitter parsers
local myParameters = vim.treesitter.query.parse("fortran",
   [[
      (parameters(identifier)@pars)
   ]]
)

local myTypes = vim.treesitter.query.parse("fortran",
   [[
      (intrinsic_type)@type
      (type_qualifier)@qual
      (derived_type)@derT
      (identifier)@id
   ]])

local myDeclarations = vim.treesitter.query.parse("fortran",
   [[
      (variable_declaration)@varDec
   ]]
)

local getTableSize = function(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end

local localPath = function()
   local path = vim.fn.expand('%')
   local source = vim.split(path, ".", true)
   local parts = vim.split(source[1],"/",true)
   name = parts[#parts] or ""
   local internal = "if"
   if name:sub(1,1) == string.upper(name:sub(1,1)) then
      internal = "f"
   end
   return "****" .. internal .. "* " .. source[1]
end

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "fortran", {})
  local tree = parser:parse()[1]
  return tree:root()
end


local getSynopsis = function(opts)
   local bufnr = opts["bufnr"] or vim.api.nvim_get_current_buf()
   if vim.bo[bufnr].filetype ~= "fortran" then
      vim.notify("can only be used with fortran")
      return ""
   end

   local root = get_root(bufnr)
   module = false
   subroutine = false
   parameters = {}
   for child in root:iter_children() do
      if child:type() ~= "comment" then
         for node in child:iter_children() do
            if node:type() == "subroutine_statement" then
                subroutine = true
             elseif node:type() == "module_statement" then
                module = true
            end
            break
         end
      end
   end

   if subroutine then
      for id, node in myParameters:iter_captures(root, bufnr, 0, -1) do
         local parm = vim.treesitter.get_node_text(node, bufnr)
         parameters[parm] = parm
      end
      if getTableSize(parameters) == 0 then
         return sn(1, t("!! call "..name.."()"))
      end
      local parTypes = {}
      -- looping through the variable declarations we focus just on the first
      for id, node in myDeclarations:iter_captures(root, bufnr, 0, -1) do
         -- loop through each of those declarations and find the variables that match the argument parameters
         local parm = {}
         local qual = nil
         local cType = nil
         local dType = nil
         local dimension = nil
         local intent = nil
         for cid, cnode in myTypes:iter_captures(node, bufnr, 0, -1) do

            if myTypes.captures[cid] == 'id' then
               local _parm = vim.treesitter.get_node_text(cnode,bufnr)
               table.insert(parm, _parm)
            elseif myTypes.captures[cid] == 'qual' then
               qual = string.lower(vim.treesitter.get_node_text(cnode,bufnr))
               if string.find(qual, "dimension") then
                  dimension = string.gsub(qual, 'dimension', '')
               elseif string.find(qual, "intent") then
                  intent = string.gsub(qual, 'intent', '')
               end
            elseif myTypes.captures[cid] == 'type' then
               cType = vim.treesitter.get_node_text(cnode,bufnr)
            elseif myTypes.captures[cid] == 'derT' then
               dType = vim.treesitter.get_node_text(cnode,bufnr)
            end
         end
         for _, p in pairs(parm) do
            if parameters[p] then
               local pardim = p
               if dimension then
                  pardim = p .. string.upper(dimension)
               end
               if dType then
                  parTypes[pardim] = dType .. string.upper(intent)
               elseif cType then
                  parTypes[pardim] = cType .. string.upper(intent)
               end
            end
         end
      end
      local nodes = {}
      local text = "!! call ".. name .. "("
      local indent = 0
      local fullText = ""
      local didText = nil
      for parm, descr in pairs(parTypes) do
         table.insert(nodes, t(string.rep(" ", indent) .. string.format("%-12s",descr) .. " :: " .. parm))
         if indent == 0 then
            indent = #text-2
         end
         if not didText then
            fullText = text .. "{}"
            didText = {}
         else
            fullText = fullText .. ",\n" .. "!!{}"
         end
      end
      fullText = fullText .. ")"
      return sn(1, fmt(fullText, nodes))
   end

   if module then
      return sn(1, t("!!   use " .. name))
   end
end

local getArguments = function()
   if module then
      return sn(1, t("!!"))
   elseif subroutine then
      local nodes = {}
      local count = 1
      local fullText = "!!\n!! ARGUMENTS\n!!\n"

      for _, parm in pairs(parameters) do
         table.insert(nodes, i(count))
         count = count + 1

         fullText = fullText .. "!!   " .. parm .. " : {}\n"
      end
      fullText = fullText .. "!!"
      return sn(1, fmt(fullText, nodes))
   end
end

ls.add_snippets("all",
{
   s(
   "robodoc",
   fmt(
   [[
   !!{}
   !!
   !! NAME
   !!
   !! {}
   !!
   !! SYNOPSIS
   !!
   {}
   !!
   !! DESCRIPTION
   !!
   !!   {}
   {}
   !! NOTES
   !!   {}
   !!***
   ]],
   {
      f(localPath, {}),
      t(name),
      d(1, getSynopsis, {}),
      i(2),
      d(3, getArguments, {}),
      i(4),
   }
   )
   ),
},
{
   key = "robodoc"
}
)

