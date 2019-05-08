class profiles::dhcp {

  class { 'dhcp':
    dnsdomain    => ['int.othalland.xyz'],
    nameservers  => ['192.168.1.121'],
    interfaces   => ['eth0'],
  }
  dhcp::pool{ 'ops.int.othalland.xyz':
    network     => '192.168.1.0',
    mask        => '255.255.255.0',
    range       => '192.168.1.210 192.168.1.240',
    gateway     => '192.168.1.1',
    nameservers => ['192.168.1.131'],
  }
}
