# Class: profile::linux::jenkinsmaster
#
#
class profile::linux::jenkinsmaster {

  
class { 'jenkins':
  config_hash => {
    'JAVA_ARGS' => { value => '-Xmx1000m -Dhudson.DNSMultiCast.disabled=true -Djava.awt.headless=true -Djenkins.install.runSetupWizard=false -Dorg.jenkinsci.plugins.gitclient.Git.timeOut=30' },
    # 'JENKINS_ARGS' => { value => '--webroot=/var/cache/jenkins/war --httpPort=$HTTP_PORT --httpListenAddress=127.0.0.1 --prefix=$PREFIX' },
  },
  lts => true,
}
  jenkins::plugin { 'structs': }
  jenkins::plugin { 'puppet-enterprise-pipeline': }
  jenkins::plugin { 'workflow-api': }
  jenkins::plugin { 'workflow-step-api': }
  jenkins::plugin { 'workflow-basic-steps': }
  jenkins::plugin { 'workflow-cps': }
  jenkins::plugin { 'workflow-durable-task-step': }
  # jenkins::plugin { 'plain-credentials': }
  jenkins::plugin { 'script-security': }
  jenkins::plugin { 'scm-api': }
  jenkins::plugin { 'workflow-support': }
  jenkins::plugin { 'durable-task': }
  jenkins::plugin { 'workflow-scm-step': }
  jenkins::plugin { 'jquery-detached': }
  jenkins::plugin { 'mailer': }
  jenkins::plugin { 'display-url-api': }
  jenkins::plugin { 'ace-editor': }
  jenkins::plugin { 'pipeline-input-step': }
  jenkins::plugin { 'workflow-job':
    version => '2.12.1',
  }
  jenkins::plugin { 'workflow-cps-global-lib': }
  jenkins::plugin { 'workflow-multibranch': }
  jenkins::plugin { 'pipeline-stage-view': }
  jenkins::plugin { 'pipeline-model-definition': }
  jenkins::plugin { 'pipeline-stage-step': }
  jenkins::plugin { 'pipeline-milestone-step': }
  jenkins::plugin { 'pipeline-rest-api': }
  jenkins::plugin { 'cloudbees-folder': }
  jenkins::plugin { 'git-server': }

  # Git Plugin
  jenkins::plugin { 'git': }
  # Dependencies
  jenkins::plugin { 'git-client': }
  jenkins::plugin { 'junit': }
  jenkins::plugin { 'matrix-project': }
  jenkins::plugin { 'ssh-credentials': }

  # SSH Plugin
  jenkins::plugin { 'ssh-agent': }
  # Dependencies
  jenkins::plugin { 'bouncycastle-api': }
  # jenkins::user { 'tragiccode':
  #   email    => 'michael@tragiccode.com',
  #   password => 'puppetlabs',
  # }
}