#!/usr/bin/env bash

# Echo message to console
# Params:
#       <color> Can be: title, error, info, warning, question, success, header
#       <message>
#
function _message(){
    local color=$1;
    local exp=$2;

    if ! [[ $color =~ '^[0-9]$' ]] ; then
        case $(echo -e $color | tr '[:upper:]' '[:lower:]') in
                # 0 = black
            title) color=0 ;;
                # 1 = red
            error) color=1 ;;
                # 2 = green
            info) color=2 ;;
                # 3 = yellow
            warning) color=3 ;;
                # 4 = blue
            question) color=4 ;;
                # 5 = magenta
            success) color=5 ;;
                # 6 = cyan
            header) color=6 ;;
                # 7 = white
            *) color=7 ;;
        esac
    fi
    tput bold;
    tput setaf $color;
    echo -e "$exp";
    tput sgr0;
}

function _is_dry_run() {
    if [[ $DRY_RUN -eq 0 ]]; then
        return 1
    else
        return 0
    fi
}

function _debug_server() {
    echo
    echo -e "・Server: ${FG_GREEN}${SERVER_NAME}${FG_DEFAULT}"
    echo -e "・SSH server name: ${FG_GREEN}${REMOTE_SSH_SERVER}${FG_DEFAULT}"
    echo -e "・Server target path: ${FG_GREEN}${REMOTE_PUBLIC}${FG_DEFAULT}"
    echo -e -n "・Is dry-run mode: "

    if ( _is_dry_run ); then
        echo -e -n "${FG_GREEN}${TXT_BOLD}YES${TXT_UN_BOLD}${FG_DEFAULT}"
    else
        echo -e -n "${FG_RED}${TXT_BOLD}NO${TXT_UN_BOLD}${FG_DEFAULT}"
    fi

    echo ${RESET}
    echo
}


function _confirm_dry_run() {
    if ( ! _is_dry_run ); then
        local message="Running in ${FG_RED}${TXT_BOLD}REAL${RESET} mode, sure?"

        if ( ! _confirm "$message" ) ;  then
            _quit
        fi
    fi
}



# Quit, write quit message to console
function _quit {
    echo
    echo
    _message success 'Bye!'
    echo
    exit 0
}


# Show confirm dialog
# Params:
#       [<message> Are you sure you want to do it?]
#       [<title> Confirm]
#
function _confirm {
    local confirm_message="${1:- Are you sure you want to do it? ${}}"
    local confirm_title="${2:-Confirm}"

    echo
    echo "---------   ${confirm_title}   ---------"
    echo

    read -p "${confirm_message} (y/n): " confirm



    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] ; then
        return 0
    else
        return 1
    fi
}


# Wait to user press any key to continue
# Params:
#       [<message> Press any key to continue...]
#
function _pause {
    local message="${1:-Press any key to continue ${ICON_EMOJI_KISS} ...}"

    echo
    echo
    echo -e -n "${message}"
    read -n 1 -s -r
    echo
}



# Call module.
# Params:
#       <task name>
#
function _task() {
    local taskName="$1"

    if [ -z "${taskName}" ]; then
        _message error "Unknown task to do"
        exit 1
    fi

    _check_tasks "${taskName}"

    echo
    echo " ${FG_DEFAULT}Executing task ${FG_GREEN}${TXT_BOLD}${taskName}${RESET}"
    echo '------------------------------------------------'
    echo


    # Require module file
    . "${APP_TASKS_DIR}/${taskName}.sh"
}

# Check task file exits, if a task not exists then throw error and exit
function _check_tasks() {
    for TASK in "$@"
    do
        local taskFile="${APP_TASKS_DIR}/${TASK}.sh"

        if [ ! -f "${taskFile}" ]; then
            _message error "Task ${FG_YELLOW}${TASK}.sh${FG_DEFAULT} is not defined ${ICON_EMOJI_ROLLING}  "

            exit 1
        fi
    done
}



# Require server info
# Exit if server name missing or server file not found
# Params:
# 		<server_name> Name of server to load
#
function _require_server() {
    local serverName="$1"

    if [ -z "${serverName}" ]; then
        _message error "Unknown server to load ${ICON_EMOJI_SCREAMING} "

        exit 1
    fi

    local serverFile="${APP_SERVERS_DIR}/${serverName}.sh"

    if [ ! -f "${serverFile}" ]; then
        _message error "Server \"${FG_YELLOW}${serverName}${FG_DEFAULT}\" is not defined ${ICON_EMOJI_ROLLING} "

        exit 1
    fi

    . "${serverFile}"
}

function _run_ssh_command() {
    local command="$1"
    local options="$2"

    ssh ${options} ${REMOTE_SSH_SERVER} "${command}"
}

function _copy_to_server() {
    local localPath="$1"
    local serverPath="${2:-${REMOTE_PUBLIC}}"
    local options="$3"

    if [[ ! -e "${localPath}" ]]; then
        _message error "Local path \"${FG_YELLOW}${localPath}${FG_DEFAULT}\" not found"

        exit 1
    fi

    echo "Copy local files (${FG_YELLOW}${localPath}${FG_DEFAULT}) to server (${FG_YELLOW}${serverPath}${FG_DEFAULT})"
    scp -r ${options} "${localPath}" "${REMOTE_SSH_SERVER}:${serverPath}"
}

function _copy_from_server() {
    local serverPath="${1}"
    local localPath="$2"
    local options="$3"

    if [[ -z "${localPath}" ]]; then
        localPath=`pwd`
    fi

    echo "Copy server files (${FG_YELLOW}${serverPath}${FG_DEFAULT}) to local (${FG_YELLOW}${localPath}${FG_DEFAULT})"
    scp -r ${options} "${localPath}" "${REMOTE_SSH_SERVER}:${serverPath}"
}

function _rsync_to_server() {
	local localPath="${1:-${PUBLIC_LOCAL}}"
    local serverPath="${2:-${REMOTE_PUBLIC}}"
    local options="${3:-${RSYNC_OPTION_PARAMETERS}}"

    if [[ ! -e "${localPath}" ]]; then
        _message error "Local path \"${FG_YELLOW}${localPath}${FG_DEFAULT}\" not found"

        exit 1
    fi

    echo "Sync local files (${FG_YELLOW}${localPath}${FG_DEFAULT}) to server (${FG_YELLOW}${serverPath}${FG_DEFAULT})"
    rsync ${options} "${localPath}" "${REMOTE_SSH_SERVER}:${serverPath}"
}

function _rsync_from_server() {
    local serverPath="${1:-${REMOTE_PUBLIC}}"
	local localPath="${2:-${PUBLIC_LOCAL}}"
    local options="${3:-${RSYNC_OPTION_PARAMETERS}}"

    echo "Sync server files (${FG_YELLOW}${serverPath}${FG_DEFAULT}) to local (${FG_YELLOW}${localPath}${FG_DEFAULT})"
    rsync ${options} "${REMOTE_SSH_SERVER}:${serverPath}" "${localPath}"
}
