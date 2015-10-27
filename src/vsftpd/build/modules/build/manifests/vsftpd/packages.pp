class build::vsftpd::packages {
  package {[
      'vsftpd'
    ]:
    ensure => present
  }
}
