class profiles::prometheus_server (
  $dns_targets,
  $clients,
  $version,
  $plex_targets,
) {

  class { 'prometheus::server':
    version           => $version,
    storage_retention => '1080h',
    scrape_configs    => [
      {
        'job_name' => 'prometheus',
        'scrape_interval' => '15s',
        'scrape_timeout'  => '10s',
        'static_configs'  => [
          {
            'targets' => ['localhost:9090'],
            'labels'  => {
              'alias'=> 'Prometheus'
            }
          }
        ]
      },
      {
        'job_name' => 'node',
        'scrape_interval' => '15s',
        'scrape_timeout'  => '10s',
        'static_configs'  => [
          {
            'targets' => $clients,
            'labels'  => {
              'alias'=> 'Node'
            }
          }
        ]
      },
      {
        'job_name' => 'coredns',
        'scrape_interval' => '15s',
        'scrape_timeout'  => '10s',
        'static_configs'  => [
          {
            'targets' => $dns_targets,
            'labels'  => {
              'alias'=> 'CoreDNS'
            }
          }
        ]
      },
      {
        'job_name' => 'plex',
        'scrape_interval' => '15s',
        'scrape_timeout'  => '10s',
        'static_configs'  => [
          {
            'targets' => $plex_targets,
            'labels'  => {
              'alias'=> 'Plex'
            }
          }
        ]
      }
    ],
  }
}
