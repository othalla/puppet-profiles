class profiles::prometheus_server (
  $clients,
) {

  class { 'prometheus':
    manage_prometheus_server => true,
    version => '2.0.0',
    alerts => { 'groups' => [{ 'name' => 'alert.rules', 'rules' => [{ 'alert' => 'InstanceDown', 'expr' => 'up == 0', 'for' => '5m', 'labels' => { 'severity' => 'page', }, 'annotations' => { 'summary' => 'Instance {{ $labels.instance }} down', 'description' => '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 5 minutes.' } }]}]},
    scrape_configs => [
      { 'job_name' => 'prometheus',
      'scrape_interval' => '10s',
      'scrape_timeout'  => '10s',
      'static_configs'  => [
        { 'targets' => [ 'localhost:9090' ],
        'labels'  => { 'alias'=> 'Prometheus'}
        }
      ]
      },
      { 'job_name' => 'node',
      'scrape_interval' => '5s',
      'scrape_timeout'  => '5s',
      'static_configs'  => [
        { 'targets' => [ 'nodexporter.domain.com:9100' ],
        'labels'  => { 'alias'=> 'Node'}
        }
      ]
      }
    ],
  }
}
