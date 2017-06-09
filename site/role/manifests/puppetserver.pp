class role::puppetserver {

  # This role would be made of all the profiles that need to be included to configure/manage our puppet enterprise server
  # All roles should include the base profile
  include profile::base
  include profile::puppetenterprise::puppetserver
  
}
