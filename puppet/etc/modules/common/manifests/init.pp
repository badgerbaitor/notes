# Assemble the common the stuff here 
class common {
  # Install needed packages
  class { common::packages :}
  # Configure samba server
  class { common::samba :}
  # Disable firewall
  class { common::firewalld :}
}
