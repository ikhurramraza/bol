if [[ -o interactive ]] && [[ -o login ]]; then
    __bol_quotes=(
        # 🧛🏻 The Originals
        "I am...immortal.\n— Klaus Mikaelson"
        "Don't underestimate the allure of darkness, Stefan.\nEven the purest hearts are drawn to it.\n— Klaus Mikaelson"
    )

    printf '%b\n\n' "${__bol_quotes[RANDOM % $#__bol_quotes + 1]}"

    unset __bol_quotes
fi
