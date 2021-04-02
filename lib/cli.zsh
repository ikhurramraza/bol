#!/usr/bin/env zsh

# ================================================================================ #
# ================================== ENTRYPOINT ================================== #
# ================================================================================ #

function bol {
  if [[ $# -eq 0 ]]; then
    _bol::help
    return 1
  fi

  local command="$1"
  shift

  local function_name="_bol::$command"

  if ! type -f $function_name >/dev/null; then
    _bol::help
    return 1
  fi

  $function_name "$@"
}

# ================================================================================ #
# =============================== AUTO COMPLETIONS =============================== #
# ================================================================================ #

function _bol {
  local -a cmds subcmds

  cmds=(
    'help:Usage information'
    'add:Add a quote'
  )

  if ((CURRENT == 2)); then
    _describe 'command' cmds
  elif ((CURRENT == 3)); then
    case "$words[2]" in
    add)
      subcmds=('help:Usage information')
      _describe 'command' subcmds
      ;;
    esac
  fi

  return 0
}

compdef _bol bol

# ================================================================================ #
# ================================= SUB COMMANDS ================================= #
# ================================================================================ #

# ============================== COMMAND: bol help =============================== #

function _bol::help {
  cat <<HELP
Usage: bol <command>

Available commands:

 help           Print this help message
 add            Add a quote
HELP
}

# =============================== COMMAND: bol add =============================== #

function _bol::add::help {
  cat <<HELP
Usage: bol add <name> <quote> [options]

All the values should be enclosed within qoutation marks. See examples.

Arguments:
  name            Short name for the quote. This should be a valid directory hierarchy.
  quote           Actual quote

Available options:

  --author        Author of the quote
  --hierarchy     Directory hierarchy of the quote

Examples:
  bol add bad-code "Code is like humor. If you have to explain it, it’s bad."
  bol add bad-code "Code is like humor. If you have to explain it, it’s bad." --author "Cory House"
  bol add bad-code "Code is like humor. If you have to explain it, it’s bad." --author "Cory House" --hierarchy "Coding/General"
HELP
}

function _bol::add {
  local EXTENSION=".txt"

  if [ -z $__BOL_QUOTES_PATH ]; then
    echo "Quote path not configured."
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    _bol::add::help
    return 1
  elif [[ $# -eq 1 ]] && [ $1 = "help" ]; then
    _bol::add::help
    return 0
  elif [[ $# -gt 1 ]]; then
    local name="$1"
    local quote="$2"
    shift 2
  else
    _bol::add::help
    return 1
  fi

  while test $# -gt 0; do
    case "$1" in
    --author)
      local author="$2"
      shift 2
      ;;
    --hierarchy)
      local hierarchy="$2/"
      shift 2
      ;;
    *)
      echo "Don't know how to handle parameters: $*"
      return 1
      ;;
    esac
  done

  if [ ! -z $hierarchy ]; then
    mkdir -p "${__BOL_QUOTES_PATH}/${hierarchy}"
  fi

  local quote_path="${__BOL_QUOTES_PATH}/${hierarchy}${name}${EXTENSION}"

  _bol::add::_preview $name $quote $author > "$quote_path"

  echo "Quote added:"
  echo ""
  cat $quote_path
  echo ""

  echo "It can be removed using: rm ${quote_path}"

  return 0
}

function _bol::add::_preview {
  local SEPARATOR="—"

  local name="$1"
  local quote="$2"
  local author="$3"

  local preview="$quote"

  if [ ! -z $author ]; then
    preview="${preview}\n${SEPARATOR} ${author}"
  fi

  echo $preview
}
