class cyrus (
  $cyrus_tls_config,
  $managed_mail_domains         = hiera('managed_mail_domains'),
  $authentication_ldap_servers  = hiera('authentication_ldap_servers', false),
  $ldap_bind_dn                 = hiera('ldap_bind_dn', false),
  $ldap_bind_pw                 = hiera('ldap_bind_pw', false)
  ) {
  include cyrus::variables

  if ! $authentication_ldap_servers or ! $ldap_bind_dn or ! $ldap_bind_pw{
    fail('You must provide valid values for LDAP connection.')
  }
  
  Ssl::Config::Cyrus[$cyrus_tls_config] -> Class['cyrus']
  
  package { [$cyrus::variables::cyrus_pkg]:
    ensure  => present
  }
  
  user { 'cyrus':
    groups  => ['ssl-cert'],
    require => Package[$cyrus::variables::cyrus_pkg],
  }
  
  file { '/etc/imapd.conf':
    mode    => 0644,
    require => Package['cyrus-imapd-2.2'],
    notify  => Service['cyrus2.2'],
    content => template('cyrus/imapd.conf.erb')
  }
  
  file { '/etc/cyrus.conf':
    mode    => 0644,
    require => Package['cyrus-imapd-2.2'],
    notify  => Service['cyrus2.2'],
    content => template('cyrus/cyrus.conf.erb')
  }
  
  service { 'cyrus2.2':
    alias       => 'cyrus',
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
    require     => Package['cyrus-imapd-2.2']
  }
}
