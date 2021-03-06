# Configure samba on home machine
class common::samba {
  # My normal mount points for hot swappable ext drives
  $sambaDirs = [
    '/data1',
    '/data2',
    '/data3',
    '/data4'
  ]
  file { $sambaDirs: ensure => directory, owner => 0, group => 0, }
  $sambaPackages = [
    'samba',
    'samba-client',
    'samba-common',
    ]
  package { $sambaPackages: ensure => 'present', allow_virtual => false, }
  group {'smbgrp':
    ensure  => present,
    name    => 'smbgrp',
    gid     => 600,
    require => Package[$sambaPackages],
  }
  file {'/etc/samba/smb.conf':
    ensure  => present,
    source  => 'puppet:///modules/common/samba/smb.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Group['smbgrp'],
    notify  => [ Service['smb'], Service['nmb'] ],
  }
  service {'smb':
    ensure  => running,
    enable  => true,
    require => File['/etc/samba/smb.conf'],
    
  }
  service {'nmb':
    ensure  => running,
    enable  => true,
    require => Service['smb'],
  }
  # Print remaining commands to console as I dont
  # like adding user/names passwords to THIS git repo.
  # TODO Hiera on home network?? :)
  notify {'Please add users to smb config with: usermod USERNAME -a -G smbgrp; smbpasswd -a USERNAME':}
}
