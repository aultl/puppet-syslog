#
# syslog - install.pp
#

# Resources related to getting the software the module manages onto the node.

class syslog::install inherits syslog {

  package { 'syslog':
    ensure => $syslog::params::package_ensure,
    name   => $syslog::params::package_name,
  }

  case $::operatingsystem {
    /Solaris/: {
      file { '/var/log/connlog':
        ensure => file,
        owner  => 'root',
        group  => 'sys',
        mode   => '0664',
      }
    }
    /RedHat|CentOS/: {
      ## TODO: remove syslogd package on el5 systems
      ## LLA 2015-11-03
      #package { 'old_syslog':
      #  ensure => absent,
      #  name   => 'syslog',
      #}
    }
    default: {
      warn("This module is not supported on $::operatingsystem")
    }
  }
}
