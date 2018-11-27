name             'grafana'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Installs/Configures Grafana Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/sous-chefs/chef-grafana'
issues_url       'https://github.com/sous-chefs/chef-grafana/issues'
chef_version     '>= 13.0'
version          '3.0.0'

supports 'ubuntu', '>= 16.04'
supports 'debian', '>= 8.0'
supports 'centos', '>= 6.4'
supports 'redhat', '>= 6.4'

depends 'nginx', '>= 7.0'
