# -*- shell-script -*-

@test "nagios is not installed" {
    [ ! -f /usr/sbin/nagios3 ]
}

@test "icinga 1.9 is installed" {
    icinga --version | grep '^Icinga 1\.'
}

@test "icinga configuration is created" {
    [ -f /etc/icinga/icinga.cfg ]
    grep '^icinga_user' /etc/icinga/icinga.cfg
    grep '^icinga_group' /etc/icinga/icinga.cfg
    grep 'rw/icinga\.cmd' /etc/icinga/icinga.cfg
}

@test "icinga objects are configured in the objects directory" {
    [ -f /etc/icinga/objects/hosts.cfg ]
}

@test "icinga server is running" {
    pidof icinga
}
