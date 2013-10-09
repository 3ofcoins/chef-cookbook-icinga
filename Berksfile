# -*- ruby -*-
site :opscode

metadata

cookbook 'nagios', git: 'https://github.com/opscode-cookbooks/nagios.git'

group :integration do
  cookbook "chef-solo-search", git: 'https://github.com/edelight/chef-solo-search.git'
  cookbook "icinga-test-helper", :path => "./test/cookbooks/icinga-test-helper"
end
