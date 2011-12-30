class cyrus (
  $cyrus_tls_config,
  $managed_mail_domains,
  $altnamespace                 = false,
  $authentication_ldap_servers  = false,
  $ldap_bind_dn                 = false,
  $ldap_bind_pw                 = false,
  $cyrus_spool_path             = false,
) {

  Class ['sasl'] -> Class ['cyrus']
  class { 'cyrus::install': } -> Class['cyrus::config'] ~> class { 'cyrus::service': }

  if ! $authentication_ldap_servers or ! $ldap_bind_dn or ! $ldap_bind_pw{
    fail('You must provide valid values for LDAP connection.')
  }

  Ssl::Config::Cyrus[$cyrus_tls_config] -> Class['cyrus']

  class { 'cyrus::config':
    cyrus_tls_config            => $cyrus::cyrus_tls_config,
    managed_mail_domains        => $cyrus::managed_mail_domains,
    altnamespace                => $cyrus::altnamespace,
    authentication_ldap_servers => $cyrus::authentication_ldap_servers,
    ldap_bind_dn                => $cyrus::ldap_bind_dn,
    ldap_bind_pw                => $cyrus::ldap_bind_pw,
  }
}

