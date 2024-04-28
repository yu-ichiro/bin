#!/bin/sh
mybin-event () {
    local help args action event
    args=()
    help=$(cat <<EOF
mybin-event [ACTION]
schedule command on declared events
ACTION:
	list                      -- list available events
	init [event]              -- initialize an event
	hook [event] [command]... -- hook command execution on a event
	dump [event]              -- dump file loaded for event
	trigger [event]           -- trigger event and removes it
EOF
	)

    while [ -n "$1" ]; do
	case "$1" in
	    -h|--help)
		echo "$help"
		return -1
		;;
	    *)
		args+=("$1")
		shift
		;;
	esac
    done
    if [ -n "${args[1]}" ]; then
        action="${args[1]}"; args=("${args[@]:1}")
    else
	echo "error: not enough arguments"
	echo $help
	return -1
    fi
    if [ -n "${args[1]}" ]; then
        event="${args[1]}"; args=("${args[@]:1}")
    elif [ "$action" != "list" ]; then
	echo "error: not enough arguments"
	echo $help
	return -1
    fi
    
    EVENT_HOME=$MYBIN_PATH/etc/run/mybin-event
    mkdir -p $EVENT_HOME
    event_file=$EVENT_HOME/$event

    case "$action" in
	list)
	    ls -1 $EVENT_HOME
	    ;;
	init)
	    if [ -e "$event_file" ]; then
		echo "event '$event' already exists. refusing to re-initialize"
		return 2
	    fi
	    touch $event_file
	    ;;
	hook)
	    if [ ! -e "$event_file" ]; then
		echo "event '$event' not found"
		return 1
	    fi
	    echo "${args[@]}" >> $event_file
	    ;;
	dump)
	    if [ ! -e "$event_file" ]; then
		echo "event '$event' not found"
		return 1
	    fi
	    cat $event_file
	    ;;
	trigger)
	    if [ ! -e "$event_file" ]; then
		echo "event '$event' not found"
		return 1
	    fi
	    source $event_file
	    rm $event_file
	    ;;
	*)
	    echo "error: unknown action: '$action'"
	    echo "$help"
	    return -1
	    ;;
    esac
}
