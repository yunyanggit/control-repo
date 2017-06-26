# Class: profile::linux::jenkinsmaster
#
#
class profile::linux::jenkinsmaster {
  include jenkins

  jenkins::plugin { 'structs': }
  jenkins::plugin { 'puppet-enterprise-pipeline': }
  jenkins::plugin { 'workflow-api': }
  jenkins::plugin { 'workflow-step-api': }
  jenkins::plugin { 'workflow-basic-steps': }
  jenkins::plugin { 'workflow-cps': }
  jenkins::plugin { 'workflow-durable-task-step': }
  jenkins::plugin { 'plain-credentials': }
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
  jenkins::plugin { 'workflow-job': }
  jenkins::plugin { 'workflow-cps-global-lib': }
  jenkins::plugin { 'workflow-multibranch': }
  jenkins::plugin { 'pipeline-stage-view': }
  jenkins::plugin { 'pipeline-model-definition': }
  jenkins::plugin { 'pipeline-stage-step': }
  jenkins::plugin { 'pipeline-milestone-step': }
}