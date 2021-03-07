if [[ -o interactive ]] && [[ -o login ]]; then
    __bol_quotes=(
    )

    printf '%b\n\n' "${__bol_quotes[RANDOM % $#__bol_quotes + 1]}"

    unset __bol_quotes
fi
