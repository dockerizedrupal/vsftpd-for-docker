class build::vsftpd {
  require build::vsftpd::packages
  require build::vsftpd::supervisor

  bash_exec { 'mkdir -p /var/run/vsftpd/empty': }
}
