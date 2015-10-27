class run::vsftpd::ssl {
  bash_exec { 'mkdir -p /vsftpd/ssl': }

  bash_exec { 'mkdir -p /vsftpd/ssl/private':
    require => Bash_exec['mkdir -p /vsftpd/ssl']
  }

  bash_exec { 'mkdir -p /vsftpd/ssl/certs':
    require => Bash_exec['mkdir -p /vsftpd/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('run/opensslCA.cnf.erb'),
    require => Bash_exec['mkdir -p /vsftpd/ssl/certs']
  }

  bash_exec { 'openssl genrsa -out /vsftpd/ssl/private/vsftpdCA.key 4096':
    timeout => 0,
    require => File['/root/opensslCA.cnf']
  }

  bash_exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /vsftpd/ssl/private/vsftpdCA.key -out /vsftpd/ssl/certs/vsftpdCA.crt":
    timeout => 0,
    require => Bash_exec['openssl genrsa -out /vsftpd/ssl/private/vsftpdCA.key 4096']
  }

  bash_exec { 'openssl genrsa -out /vsftpd/ssl/private/vsftpd.key 4096':
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /vsftpd/ssl/private/vsftpdCA.key -out /vsftpd/ssl/certs/vsftpdCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('run/openssl.cnf.erb'),
    require => Bash_exec['openssl genrsa -out /vsftpd/ssl/private/vsftpd.key 4096']
  }

  bash_exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /vsftpd/ssl/private/vsftpd.key -out /vsftpd/ssl/certs/vsftpd.csr":
    timeout => 0,
    require => File['/root/openssl.cnf']
  }

  bash_exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /vsftpd/ssl/certs/vsftpd.csr -CA /vsftpd/ssl/certs/vsftpdCA.crt -CAkey /vsftpd/ssl/private/vsftpdCA.key -out /vsftpd/ssl/certs/vsftpd.crt":
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -new -config /root/openssl.cnf -key /vsftpd/ssl/private/vsftpd.key -out /vsftpd/ssl/certs/vsftpd.csr"]
  }
}
