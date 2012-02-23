class cyrus::config (
  $cyrus_tls_config,
  $managed_mail_domains,
  $altnamespace,
  $authentication_ldap_servers,
  $ldap_base,
  $ldap_bind_dn,
  $ldap_bind_pw,
  $cyrus_sieve_bind,
) {

  include cyrus::variables

  file { '/etc/imapd.conf':
    mode    => '0644',
    content => template('cyrus/imapd.conf.erb')
  }

  file { '/etc/cyrus.conf':
    mode    => '0644',
    content => template('cyrus/cyrus.conf.erb')
  }
}

