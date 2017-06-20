class role::domaincontroller {

  #This role would be made of all the profiles that need to be included to make a domaincontroller work
  #All roles should include the base profile
  include profile::base
  include profile::activedirectory::domaincontroller
  include profile::activedirectory::groups
  include profile::activedirectory::users

  Class['profile::activedirectory::domaincontroller']
  -> Class['profile::activedirectory::users']
  -> Class['profile::activedirectory::ous']
  -> Class['profile::activedirectory::groups']
}
