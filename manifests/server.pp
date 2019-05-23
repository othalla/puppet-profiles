class profiles::server {
  include ::network
  include ::packages
  include ::sudo
  include ::henrylf
  class { '::locales':
    default_locale => 'en_US.UTF-8',
    locales        => ['en_US.UTF-8 UTF-8'],
  }
  class { 'ssh::server':
    storeconfigs_enabled => false,
    options => {
      'PasswordAuthentication' => 'no',
      'PermitRootLogin'        => 'no',
      'Port'                   => 22,
      'AllowUsers'             => 'henrylf',
      'PermitEmptyPasswords'   => 'no',
      'ClientAliveInterval'    => 300,
      'ClientAliveCountMax'    => 0,
      'AuthenticationMethods'  => 'publickey',
      'PubkeyAuthentication'   => 'yes',
    },
  }
  class { '::dnsclient':
    nameservers => ['192.168.1.131', '192.168.1.120'],
    domain      => 'int.othalland.xyz',
    search      => ['int.othalland.xyz'],
  }
}
