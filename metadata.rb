name             "icinga"
maintainer       "Maciej Pasternacki"
maintainer_email "maciej@3ofcoins.net"
license          'MIT'
description      "Icinga"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'nagios', '>= 4.1.5'
