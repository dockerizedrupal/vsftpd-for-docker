class run::vsftpd {
  if ! file_exists('/vsftpd/ssl/certs/vsftpd.crt') {
    require run::vsftpd::ssl
  }

  file { '/etc/vsftpd.conf':
    ensure => present,
    content => template('run/vsftpd.conf.erb'),
    mode => 644
  }

  file { '/usr/local/bin/user_generator':
    ensure => present,
    content => template('run/user_generator.sh.erb'),
    mode => 755
  }

  bash_exec { 'user_generator':
    timeout => 0,
    require => File['/usr/local/bin/user_generator']
  }
}
