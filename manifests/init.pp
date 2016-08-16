#
# syslog -- init.pp

# The main class of a module is its interface point and
# ought to be the only parameterized class if possible.
# This class should provide sensible defaults so that a user
# can get going with include module.

class syslog (
  # Determines the name of the package to install.
  # Default: syslog
  $package_name   = $syslog::params::package_name,

  # Determines if the service should be enabled at boot.
  # Default: true
  $service_enable = $syslog::params::service_enable,

  # Determines if the service should be running or not.
  # Default: true
  $service_ensure = $syslog::params::service_ensure,

  # Selects whether Puppet should manage the service.
  # Default: true
  $service_manage = $syslog::params::service_manage,

  # Selects the name of the syslog service for Puppet to manage.
  # Default: (depends on OS)
  $service_name   = $syslog::params::service_name,

  # Where should syslog traffic go by default?
  # Default: syslog.exmple.tld
  $syslog_target  = $syslog::params::syslog_target,

  # Should syslog listen on the network?
  # Default: no
  $syslog_receive  = $syslog::params::syslog_receive,
  $syslog_protocol = $syslog::params::syslog_protocol,

  # What port should we listen on?
  $syslog_port     = $syslog::params::syslog_port,

  # Should we support messages larger than 2k?
  $syslog_messagesize = $syslog::params::syslog_messagesize,

) inherits syslog::params {

  anchor { 'syslog::begin': }
    -> class { '::syslog::install': }
    -> class { '::syslog::config': }
    ~> class { '::syslog::service': }
    -> anchor { 'syslog::end': }

  validate_bool($syslog_receive)
  validate_string($syslog_target)
  validate_string($syslog_port)
  validate_array_member($syslog_protocol, ['udp', 'tcp', 'both'])
}
