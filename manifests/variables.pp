class cyrus::variables {
  if $::lsbdistid in ['Ubuntu', 'Debian'] {
    $cyrus_pkg = ['cyrus-admin-2.2', 'cyrus-clients-2.2', 'cyrus-imapd-2.2', 'cyrus-pop3d-2.2', 'cyrus-sasl2-doc', 'cyrus-doc-2.2']
  }
  else {
    fail( "This module doesn't handle your operating system yet." )
  }
}
