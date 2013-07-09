# -*- ruby -*-
site :opscode

metadata

cookbook 'nagios',
         git: 'https://github.com/mpasternacki/nagios.git',
         branch: 'COOK-3287'

group :integration do
  cookbook "chef-solo-search", github: 'edelight/chef-solo-search'
  cookbook "icinga-test-helper", :path => "./test/cookbooks/icinga-test-helper"
end
