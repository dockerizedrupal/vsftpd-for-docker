#!/usr/bin/env bash

puppet apply --modulepath=/src/vsftpd/run/modules /src/vsftpd/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf
