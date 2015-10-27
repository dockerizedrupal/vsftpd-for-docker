#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/vsftpd/build.sh && /src/vsftpd/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/vsftpd/variables.sh && /src/vsftpd/run.sh"
    ;;
esac
