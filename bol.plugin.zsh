if [[ -o interactive ]] && [[ -o login ]]; then
    __BOL_SCRIPT_PATH="$(
        cd -- "$(dirname "$0")" >/dev/null 2>&1
        pwd -P
    )"

    __BOL_QUOTES_PATH="${__BOL_SCRIPT_PATH}/quotes"

    for _bol_config_file in ${__BOL_SCRIPT_PATH}/lib/**/*.zsh; do
        source "$_bol_config_file"
    done

    [ -z $BOL_QUIET_MODE ] && bol print

    unset _bol_config_file

    unset __BOL_SCRIPT_PATH
fi
