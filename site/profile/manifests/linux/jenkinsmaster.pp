# Class: profile::linux::jenkinsmaster
#
#
class profile::linux::jenkinsmaster {
  file { ['/var/lib/jenkins', '/var/lib/jenkins/secrets', '/var/lib/jenkins/init.groovy.d']:
    ensure => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0755',
  }
  # Disable Unlock Jenkins page
  file { '/var/lib/jenkins/jenkins.install.UpgradeWizard.state':
    content => '2.0',
    ensure  => file,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0755',
  }

  file { '/var/lib/jenkins/secrets/slave-to-master-security-kill-switch':
    content => 'false',
    ensure  => file,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0755',
  }

  $content = @(EOF)
    #!groovy

    import jenkins.model.*
    import hudson.security.*

    def instance = Jenkins.getInstance()

    println "--> creating local user 'admin'"

    def hudsonRealm = new HudsonPrivateSecurityRealm(false)
    hudsonRealm.createAccount('admin','admin')
    instance.setSecurityRealm(hudsonRealm)

    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
    strategy.setAllowAnonymousRead(false)
    instance.setAuthorizationStrategy(strategy)
    instance.save()
  EOF
  
  file { '/var/lib/jenkins/init.groovy.d/basic-security.groovy':
    content => $content,
    ensure  => file,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0755',
  }


  class { 'jenkins':
    version            => 'latest',
    lts                => true,
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