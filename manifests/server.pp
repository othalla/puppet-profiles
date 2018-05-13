class profiles::server {
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
}
