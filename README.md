icinga cookbook
===============

This cookbook overrides attributes and modifies some resources of
[Opscode's `nagios` cookbook](http://community.opscode.com/cookbooks/nagios)
to make it install and configure Icinga instead.

This cookbook's home is at https://github.com/3ofcoins/chef-cookbook-icinga/

Requirements
------------

 * nagios >= 5.0.0
 * apt

Usage
-----

Include the Git version of the Nagios cookbook and this cookbook. Call
out to `icinga::server` rather than `nagios::server`, but other than
that do exactly as `nagios` cookbook documents. All the attributes are
still in the `nagios` hierarchy, data bag names are the same, and main
service of Icinga server is `service[nagios]` to Chef. It's
intentional, in order to be 100% compatible not only with Nagios
cookbook, but also for any cookbook or howto that needs it.

For symmetry, you can also use `icinga::client`, though it just calls
out to `nagios::client` at the moment.

If you use Berkshelf, you can include following code in your Berksfile
to use proper versions:

```ruby
cookbook 'nagios', git: 'https://github.com/opscode/nagios.git'
cookbook 'icinga', git: 'https://github.com/3ofcoins/chef-cookbook-icinga.git'
```

Attributes
----------

None.

Recipes
-------

 * `icinga::default` -- includes `icinga::client`
 * `icinga::client` -- includes `nagios::client`
 * `icinga::server` -- the proper thing: calls `nagios::server`
   cookbook, but tricks it to install Icinga instead.

Author
------

Author:: Maciej Pasternacki <maciej@3ofcoins.net>
