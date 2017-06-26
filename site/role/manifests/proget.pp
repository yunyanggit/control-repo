# Class: role::proget
#
#
class role::proget {
  include profile::base
  include profile::windows::packagemanagement::proget
}