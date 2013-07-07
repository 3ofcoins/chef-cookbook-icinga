# -*- ruby -*-
site :opscode

metadata

cookbook 'nagios',
         git: 'https://github.com/mpasternacki/nagios.git',
         branch: 'COOK-3287'

group :integration do
  cookbook "minitest-handler"
  cookbook "icinga-test", :path => "./test/cookbooks/icinga-test"
end
