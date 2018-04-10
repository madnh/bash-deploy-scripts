#!/usr/bin/env bash


#
# Analy optional options and task
# ----------------------------------------

SERVER_TARGET=''

POSITIONAL=()

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
            # Example of option:
            # -e|--extension)
            #     EXTENSION="$2"
            #     shift # past argument
            #     shift # past value
            #     ;;
        -s|--server)
            SERVER_TARGET="$2"
            shift # past argument
            shift # past value
            ;;
        --real)
            DRY_RUN=0
            shift # past argument
            ;;

        --dry-run)
            DRY_RUN=1
            shift # past argument
            ;;

        --exclude-file)
            IGNORE_FILE="$2"
            shift # past argument
            shift # past value
            ;;

        --delete)
            RSYNC_DELETEABLE=1
            shift # past argument
            ;;

        *)    # unknown option
            if  [[ "$1" == -* ]] ; then
                _message error "The \"${FG_YELLOW}${1}${FG_DEFAULT}\" option does not exist ${ICON_EMOJI_CRAZY_FACE}  "

                exit 1
            fi

            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ $# -eq 0 ]]; then
    POSITIONAL+=("${DEFAULT_TASK}")
fi

# Require server
# ----------------------------------------

if [[ -z "$SERVER_TARGET" ]]; then
    _message error "Unknow server to deploy ${ICON_EMOJI_DISAPPOINTED_FACE}   "
    _message error "Please provide server name via option \"${FG_YELLOW}-s${FG_DEFAULT}\" or \"${FG_YELLOW}--server${FG_DEFAULT}\""

    exit 1
fi

_require_server "$SERVER_TARGET"
_debug_server
_confirm_dry_run


# Update options
# ----------------------------------------

RSYNC_OPTION_PARAMETERS="${RSYNC_OPTION_PARAMETERS} --exclude-from=${IGNORE_FILE}"

if [[ RSYNC_DELETEABLE -eq 1 ]]; then
    RSYNC_OPTION_PARAMETERS="${RSYNC_OPTION_PARAMETERS} --delete"
fi
