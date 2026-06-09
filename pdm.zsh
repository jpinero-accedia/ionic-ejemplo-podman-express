#! /usr/bin/env zsh
# vim: ft=zsh: ts=3: sw=3: noet:

function () {
    typeset -g __BASE_FOLDER
    typeset -g __DOCKER_FOLDER

    local bdir

    bdir=${(%):-'x'}
    bdir=${bdir:a}
    bdir=${bdir:h}

    __BASE_FOLDER=${bdir}
    __DOCKER_FOLDER=${bdir}/docker
}


fucntion __help () {
    cat - <<'eos'

pdm CMD args
    CMD: up down purge help 
eos

}


function __run () {
    typeset -g __DOCKER_FOLDER

    local    CMD
    local -a theargs

    # get the cmd
    CMD=${(L)1:-empty}
    theargs=( ${@[2,-1]} )

    # cd
    cd "${__DOCKER_FOLDER}"

    # parse & exec
    print -u2     - "\e[92mCOMMAND\e[0m ${CMD}" 
    print -u2     - "\e[92mARGUMENTS\e[0m"
    print -u2 -C1 - '   '${^theargs}
    print -u2

    case "${CMD}"; in 
        up)    podman compose up      "${(@)theargs}" ;;
        down)  podman compose down    "${(@)theargs}" ;;
        purge) podman compose down -v "${(@)theargs}" ;;
        help)                                  __help ;;
        *)
            print -u2 - "ERR: Unvalid command ${(qq)CMD}"
            return 200
            ;;
    esac
}

__run "${@}"
