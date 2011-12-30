class cyrus::service {

  service { 'cyrus2.2':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

