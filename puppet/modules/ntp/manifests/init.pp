# Thic class create ntp module
class ntp(
$service_state = 'running',
  $serversList=hiera('ntp::servers',
    ['0.centos.pool.ntp.org iburst',
    '1.centos.pool.ntp.org iburst',
    '2.centos.pool.ntp.org iburst',
    '3.centos.pool.ntp.org iburst']),
    ){

  package { 'ntp':
    ensure => installed,
  }


  file {'/etc/ntp.conf':
    ensure  => file,
    content => template('ntp/ntp.conf.erb'),
    require => Package['ntp'],
    notify  => Service['ntpd'],

  }

  service { 'ntpd':
    ensure     => $service_state,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

}