# Class: profile::linux::jenkinsmaster
#
#
class profile::linux::jenkinsmaster {
    include jenkins

    jenkins::plugin { 'puppet-enterprise-pipeline': }
}