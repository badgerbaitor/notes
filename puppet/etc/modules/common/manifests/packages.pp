## Install common packages used by all centos versions.
class common::packages {
  $removePackages = [
    'fuse-ntfs-3g-2013.1.13-2.el6.rf.x86_64',
    'emacs',
    'pico', ]
  package { $removePackages:, ensure => 'absent' }

  $defaultPackages = [
    'bind-utils',
    'cifs-utils',
    'curl',
    'gcc',
    'git2u',
    'lsof',
    'make',
    'mlocate',
    'rsync',
    'tmux',
    'telnet',
    'strace',
    'vim-minimal',
    'vim-enhanced',
    'openssh-clients',
    'wget',
    'yum-utils',
    ]
  package { $defaultPackages:, ensure => 'present' }

  if $::operatingsystem == 'CentOS'{
    package { 'epel-release':,
      ensure => installed,
    }
  }
}
