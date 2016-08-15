class syslog::params {
  $service_ensure     = 'running'
  $service_enable     = true
  $service_manage     = true

  $package_ensure     = 'present'

  $config_file_owner  = 'root'

  $syslog_target      = 'syslog.example.tld'
  $syslog_receive     = false
  $syslog_protocol    = 'udp'
  $syslog_port        = '514'
  $syslog_messagesize = ''

  case $::operatingsystem {
      'Solaris': {
        $package_name  = $::operatingsystemrelease ? {
          /^(5\.10|10|10_u\d+)$/ => 'SUNWcsu',
          /^(5\.11|11|11\.\d+)$/ => 'pkg:/system/core-os', # this is useless
        }

        $service_name       = 'svc:/system/system-log'
        $config_file_path   = '/etc/syslog.conf'
        $source_config_file = 'syslog.sol.erb'
        $config_file_group  = 'sys'
      }

      /RedHat|CentOS/: {
        $package_name       = 'rsyslog'
        $service_name       = 'rsyslog'
        $config_file_path   = '/etc/rsyslog.conf'
        $source_config_file = 'syslog.el.erb'
        $config_file_group  = 'root'
      }

      default: {
        fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
      }
  }
}
