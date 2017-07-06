# Class: profile::windows::ravendb
#
#
class profile::windows::ravendb {

    class { 'ravendb':
      package_ensure                         => 'present',
      ravendb_service_name                   => 'RavenDB',
      ravendb_port                           => 8080,
      ravendb_target_environment             => 'development',
      ravendb_database_directory             => 'C:\\RavenDB\\Databases',
      ravendb_filesystems_database_directory => 'C:\\RavenDB\\FileSystems',
      service_ensure                         => 'running',
      service_enable                         => true,
    }

}