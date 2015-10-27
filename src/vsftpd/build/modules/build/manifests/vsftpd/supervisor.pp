class build::vsftpd::supervisor {
  file { '/etc/supervisor/conf.d/vsftpd.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/vsftpd.conf',
    mode => 644
  }
}
