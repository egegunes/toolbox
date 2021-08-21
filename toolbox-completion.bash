#/usr/bin/env bash

_toolbox_get_firstword() {
    local firstword i

    firstword=
    for ((i = 1; i < ${#COMP_WORDS[@]}; ++i)); do
        if [[ ${COMP_WORDS[i]} != -* ]]; then
            firstword=${COMP_WORDS[i]}
            break
        fi
    done

    echo $firstword
}

_toolbox_get_lastword() {
    local lastword i

    lastword=
    for ((i = 1; i < ${#COMP_WORDS[@]}; ++i)); do
        if [[ ${COMP_WORDS[i]} != -* ]] && [[ -n ${COMP_WORDS[i]} ]] && [[ ${COMP_WORDS[i]} != $cur ]]; then
            lastword=${COMP_WORDS[i]}
        fi
    done

    echo $lastword
}

_toolbox_completions() {
    firstword=$(_toolbox_get_firstword)
    lastword=$(_toolbox_get_lastword)
    cur=${COMP_WORDS[COMP_CWORD]}

    case "${firstword}" in
    run)
        complete_words=$(toolbox ls)
        ;;
    edit)
        complete_words=$(toolbox ls)
        ;;
    *)
        complete_words=("add edit run init ls")
    esac

    COMPREPLY=( $( compgen -W "$complete_words" -- $cur ))
}

complete -F _toolbox_completions toolbox
