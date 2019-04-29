class profiles::dns {

  $zone_directory = '/etc/coredns/zones'
  $zone_name = 'int.othalland.xyz'

  include ::coredns
  class { 'dns_zones':
    dns_zones_directory => $zone_directory,
  }
  coredns::zone { '.':
  listen_port                  => 53,
  prometheus                   => true,
  prometheus_listen_address    => $facts['ipaddress'],
  prometheus_listen_port       => 1024,
  forward                      => true,
  forward_from                 => '.',
  forward_to                   => ['192.168.1.1'],
  auto                         => $zone_name,
  auto_config                  => {
    'directoryx' => $zone_directory,
  },
  log                          => true,
  errors                       => true,
  }
}
