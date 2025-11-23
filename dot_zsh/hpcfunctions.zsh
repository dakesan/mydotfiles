function r-conda () {
  path_append "$HOME/miniconda3/envs/r4_env/bin"
  export R_BINARY="$HOME/miniconda3/envs/r4_env/bin/R"
  export R_HOME="$HOME/miniconda3/envs/r4_env/bin/R"
}

function r-hpcs01 () {
  alias R="/opt/R/4.2.0/lib64/R/bin/R"
  alias radian="radian --r-binary=/opt/R/4.2.0/lib64/R/bin/R"
}

function killme () {
  echo "Are you sure to kill all your processes?[y/N]"
  read str
  case $str in
  [Yy])
    sudo -u oodake kill -SIGKILL -1
    ;;
  *)
    echo "You're going to stay on it. Understood."
    ;;
  esac
}

psucks () { ps aux | grep oodake | rg $1 }
ppurge () { psucks $1 | awk '{print $2}' | xargs -I% sudo kill % }

#* proxy
function useproxy () {
    echo "proxy were setted to $PROXY_VAL."
    export http_proxy=$PROXY_VAL
    export https_proxy=$PROXY_VAL
    export ftp_proxy=$PROXY_VAL
}

function noproxy () {
    export http_proxy=
    export https_proxy=
    export ftp_proxy=
}
