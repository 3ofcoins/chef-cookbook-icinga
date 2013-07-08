apt_repository "backports" do
  uri "http://backports.debian.org/debian-backports"
  distribution "#{node['lsb']['codename']}-backports"
  components ["main"]
  action :add
  only_if { node['platform'] == 'debian' and
    node['lsb']['codename'] == 'squeeze' and
    node['nagios']['server']['install_method'] == 'package' }
end

apt_repository "debmon" do
  uri "http://debmon.org/debmon"
  distribution "debmon-#{node['lsb']['codename']}"
  components ["main"]
  keyserver "keys.gnupg.net"
  key "29D662D2"
  action :add
  only_if { node['platform'] == 'debian' and
    node['nagios']['server']['install_method'] == 'package' }
end

apt_repository "icinga" do
  uri "http://ppa.launchpad.net/formorer/icinga/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "36862847"
  action :add
  only_if { node['platform'] == 'ubuntu' and
    node['nagios']['server']['install_method'] == 'package' }
end

include_recipe 'nagios::server'

chef_gem 'chef-rewind'
require 'chef/rewind'

begin
  rewind 'execute[preseed nagiosadmin password]' do
    action :nothing
  end
rescue Chef::Exceptions::ResourceNotFound
  # Seems we're trying to install from source
end

begin
  rewind 'package[nagios-nrpe-plugin]' do
    # Debian/Ubuntu nagios-nrpe-plugin package recommends nagios3
    # package, and at least some base systems follow recommendations
    # automatically. In effect, if we want to use Icinga, we end up with
    # both Icinga and an unconfigured Nagios. We want to prevent Apt
    # from doing that.
    options '--no-install-recommends' if node['platform_family'] == 'debian'
  end
rescue Chef::Exceptions::ResourceNotFound
  # Seems we're trying to install from source
end
