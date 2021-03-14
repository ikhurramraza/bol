if [[ -o interactive ]] && [[ -o login ]]; then
    __BOL_SCRIPT_PATH="$(
        cd -- "$(dirname "$0")" >/dev/null 2>&1
        pwd -P
    )"

    __BOL_QUOTES_PATH="${__BOL_SCRIPT_PATH}/quotes"

    cat $(ls -d ${__BOL_QUOTES_PATH}/**/*.txt | shuf -n 1) && echo ""

    unset __BOL_SCRIPT_PATH
    unset __BOL_QUOTES_PATH
fi
