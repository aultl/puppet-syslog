#
# syslog -- config.pp
#

# Resources related to configuring installed software.

class syslog::config inherits syslog {

  file { 'syslog.conf':
    ensure  => file,
    path    => $config_file_path,
    mode    => '0644',
    owner   => $config_file_owner,
    group   => $config_file_group,
    content => template("syslog/${source_config_file}"),
    audit   => content,
    notify  => Service['syslog'],
  }
}
