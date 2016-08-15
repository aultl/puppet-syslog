#
# syslog -- service.pp
#

# service resources, and anything else related to the running state of
# the software, should be contained in the service class.

class syslog::service inherits syslog {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'syslog':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
