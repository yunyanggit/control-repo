class role::puppetserver {

  #This role would be made of all the profiles that need to be included to make a puppetserver work
  #All roles should include the base profile
  include profile::base
  include profile::puppetenterprise::puppetserver

}
