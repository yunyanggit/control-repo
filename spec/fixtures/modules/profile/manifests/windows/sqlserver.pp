# Class: profile::windows::sqlserver
#
#
class profile::windows::sqlserver {
  dsc_xsqlserversetup { 'Install SQL Server':
    ensure => 'present',
  # Features = $Configuration.InstallSQL.Features
  # InstanceName = $Configuration.InstallSQL.InstanceName
  # SQLCollation = $Configuration.InstallSQL.SQLCollation
  # SQLSysAdminAccounts = $Configuration.InstallSQL.SQLSysAdminAccounts
  # InstallSQLDataDir = $Configuration.InstallSQL.InstallSQLDataDir
  # SQLUserDBDir = $Configuration.InstallSQL.SQLUserDBDir
  # SQLUserDBLogDir = $Configuration.InstallSQL.SQLUserDBLogDir
  # SQLTempDBDir = $Configuration.InstallSQL.SQLTempDBDir
  # SQLTempDBLogDir = $Configuration.InstallSQL.SQLTempDBLogDir
  # SQLBackupDir = $Configuration.InstallSQL.SQLBackupDir

  # SourcePath = $Configuration.InstallSQL.SourcePath
  # SetupCredential = $Node.InstallerServiceAccount
  }
}