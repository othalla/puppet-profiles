class profiles::physical {

  class {'prometheus::node_exporter':
    version => '0.16.0',
  }

  class { '::chrony':
    servers            => [
      '0.fr.pool.ntp.org',
      '1.fr.pool.ntp.org',
      '2.fr.pool.ntp.org',
      '3.fr.pool.ntp.org',
    ],
    chrony_password    => 'unset',
    config_keys_manage => false,
  }
}
