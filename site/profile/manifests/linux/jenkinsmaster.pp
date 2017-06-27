# Class: profile::linux::jenkinsmaster
#
#
class profile::linux::jenkinsmaster {
  exec { 'turn off autostart apt package install':
    command => "echo -e '#!/bin/sh\\nexit 101' | install -m 755 /dev/stdin /usr/sbin/policy-rc.d && apt-get install jenkins && rm -f /usr/sbin/policy-rc.d",
    path   => [ '/usr/local/bin/', '/bin/' ],
  }

  # class { 'jenkins':
  #   version            => 'latest',
  #   lts              => true,
  # }


  # jenkins::plugin { 'structs': }
  # jenkins::plugin { 'puppet-enterprise-pipeline': }
  # jenkins::plugin { 'workflow-api': }
  # jenkins::plugin { 'workflow-step-api': }
  # jenkins::plugin { 'workflow-basic-steps': }
  # jenkins::plugin { 'workflow-cps': }
  # jenkins::plugin { 'workflow-durable-task-step': }
  # jenkins::plugin { 'plain-credentials': }
  # jenkins::plugin { 'script-security': }
  # jenkins::plugin { 'scm-api': }
  # jenkins::plugin { 'workflow-support': }
  # jenkins::plugin { 'durable-task': }
  # jenkins::plugin { 'workflow-scm-step': }
  # jenkins::plugin { 'jquery-detached': }
  # jenkins::plugin { 'mailer': }
  # jenkins::plugin { 'display-url-api': }
  # jenkins::plugin { 'ace-editor': }
  # jenkins::plugin { 'pipeline-input-step': }
  # jenkins::plugin { 'workflow-job':
  #   version => '2.12.1',
  # }
  # jenkins::plugin { 'workflow-cps-global-lib': }
  # jenkins::plugin { 'workflow-multibranch': }
  # jenkins::plugin { 'pipeline-stage-view': }
  # jenkins::plugin { 'pipeline-model-definition': }
  # jenkins::plugin { 'pipeline-stage-step': }
  # jenkins::plugin { 'pipeline-milestone-step': }
  # jenkins::plugin { 'pipeline-rest-api': }
  # jenkins::plugin { 'cloudbees-folder': }
  # jenkins::plugin { 'git-server': }
  # jenkins::plugin { 'pipeline-graph-analysis':  }
  # jenkins::plugin { 'branch-api':  }

  # # Git Plugin
  # jenkins::plugin { 'git': }
  # # Dependencies
  # jenkins::plugin { 'git-client': }
  # jenkins::plugin { 'junit': }
  # jenkins::plugin { 'matrix-project': }
  # jenkins::plugin { 'ssh-credentials': }

  # # SSH Plugin
  # jenkins::plugin { 'ssh-agent': }
  # # Dependencies
  # jenkins::plugin { 'bouncycastle-api': }
  # jenkins::user { 'tragiccode':
  #   email    => 'michael@tragiccode.com',
  #   password => 'puppetlabs',
  # }
}