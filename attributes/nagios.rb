include_attribute 'nagios'
include_attribute 'nagios::client'
include_attribute 'nagios::server'

default['nagios']['server']['name'] = 'icinga'
default['nagios']['server']['vname'] = 'icinga'
default['nagios']['server']['service_name'] = 'icinga'

default['nagios']['server']['packages'] = [ 'icinga', 'nagios-nrpe-plugin', 'nagios-images' ]

default['nagios']['server']['url'] = 'http://prdownloads.sourceforge.net/sourceforge/icinga'
default['nagios']['server']['version'] = '1.9.2'
default['nagios']['server']['checksum'] = 'ad9b983917e1dfab8a59c1873c71842fd3ddb38921bec9207456d47f1cb2f3a7'
default['nagios']['server']['src_dir'] = 'icinga-1.9.2'

default['nagios']['pagerduty']['script_url'] = 'https://raw.github.com/PagerDuty/pagerduty-icinga-pl/master/pagerduty_icinga.pl'

default['nagios']['home']       = '/usr/lib/icinga'
default['nagios']['conf_dir']   = '/etc/icinga'
default['nagios']['config_dir'] = '/etc/icinga/objects'
default['nagios']['log_dir']    = '/var/log/icinga'
default['nagios']['cache_dir']  = '/var/cache/icinga'
default['nagios']['state_dir']  = '/var/lib/icinga'
default['nagios']['run_dir']    = '/var/run/icinga'
default['nagios']['docroot']    = '/usr/share/icinga/htdocs'
