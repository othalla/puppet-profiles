class profiles::prometheus_server (
  $dns_targets,
  $clients,
  $version,
) {

  class { 'prometheus::server':
    version           => $version,
    storage_retention => '1080h',
    alerts            => { 'groups' => [{ 'name' => 'alert.rules', 'rules' => [{ 'alert' => 'InstanceDown', 'expr' => 'up == 0', 'for' => '5m', 'labels' => { 'severity' => 'page', }, 'annotations' => { 'summary' => 'Instance {{ $labels.instance }} down', 'description' => '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 5 minutes.' } }]}]},
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
      }
    ],
  }
}
