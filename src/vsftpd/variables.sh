#!/usr/bin/env bash

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

if [ -z "${TIMEZONE}" ]; then
  TIMEZONE="Etc/UTC"
fi

export FACTER_TIMEZONE="${TIMEZONE}"

for VARIABLE in $(env); do
  if [[ "${VARIABLE}" =~ ^VSFTPD_[[:digit:]]+_USERNAME=.*$ ]]; then
    i="$(echo ${VARIABLE} | awk -F '_' '{ print $2 }')"

    VSFTPD_USERNAME="VSFTPD_${i}_USERNAME"
    VSFTPD_PASSWORD="VSFTPD_${i}_PASSWORD"
    VSFTPD_HOME="VSFTPD_${i}_HOME"
    VSFTPD_USER_ID="VSFTPD_${i}_USER_ID"
    VSFTPD_GROUP_ID="VSFTPD_${i}_GROUP_ID"

    if [ -z "${!VSFTPD_USERNAME}" ]; then
      continue
    fi

    if [ -z "${!VSFTPD_PASSWORD}" ]; then
      continue
    fi

    if [ -z "${!VSFTPD_HOME}" ]; then
      continue
    fi

    if [ -z "${!VSFTPD_USER_ID}" ]; then
      declare "${VSFTPD_USER_ID}=1000"
    fi

    if [ -z "${!VSFTPD_GROUP_ID}" ]; then
      declare "${VSFTPD_GROUP_ID}=1000"
    fi

    export "FACTER_${VSFTPD_USERNAME}=${!VSFTPD_USERNAME}"
    export "FACTER_${VSFTPD_PASSWORD}=${!VSFTPD_PASSWORD}"
    export "FACTER_${VSFTPD_HOME}=${!VSFTPD_HOME}"
    export "FACTER_${VSFTPD_USER_ID}=${!VSFTPD_USER_ID}"
    export "FACTER_${VSFTPD_GROUP_ID}=${!VSFTPD_GROUP_ID}"
  fi
done
