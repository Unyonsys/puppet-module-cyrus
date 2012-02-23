class cyrus (
  $cyrus_tls_config,
  $managed_mail_domains,
  $ldap_bind_pw,
  $ldap_bind_dn                 = 'cn=manager,dc=root',
  $ldap_base                    = 'dc=root',
  $authentication_ldap_servers  = [ 'ldap://localhost' ],
  $altnamespace                 = false,
  $cyrus_sieve_bind             = 'localhost:sieve',
) {

  validate_array( $managed_mail_domains, $authentication_ldap_servers)
  validate_bool( $altnamespace)
  validate_string( $cyrus_tls_config, $ldap_base, $ldap_bind_dn, $ldap_bind_pw, $cyrus_sieve_bind)

  Class ['sasl'] -> Class ['cyrus']
  class { 'cyrus::install': } -> Class['cyrus::config'] ~> class { 'cyrus::service': }

  Ssl::Config::Cyrus[$cyrus_tls_config] -> Class['cyrus']

  class { 'cyrus::config':
    cyrus_tls_config            => $cyrus::cyrus_tls_config,
    managed_mail_domains        => $cyrus::managed_mail_domains,
    ldap_bind_pw                => $cyrus::ldap_bind_pw,
    ldap_bind_dn                => $cyrus::ldap_bind_dn,
    ldap_base                   => $cyrus::ldap_base,
    authentication_ldap_servers => $cyrus::authentication_ldap_servers,
    altnamespace                => $cyrus::altnamespace,
    cyrus_sieve_bind            => $cyrus::cyrus_sieve_bind,
  }
}
