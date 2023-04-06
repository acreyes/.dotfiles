up(){
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

mpgdb(){
    export TMUX_MPI_MPIRUN="mpirun --oversubscribe"
    # Start a xterm that connects to the session
    export TMUX_MPI_POST_LAUNCH="xterm -e 'tmux attach -t TMUX_MPI_SESSION_NAME'"
    # use panes not windows
    export TMUX_MPI_MODE=pane
    #synchronised inputs
    export TMUX_MPI_SYNC_PANES=1
    # launch tmux-mpi
    tmux-mpi $1 gdb $2 
}


ffmpeg_mv(){
  ffmpeg -r 15 -i $1 -pix_fmt yuv420p -crf 1 $2
}
