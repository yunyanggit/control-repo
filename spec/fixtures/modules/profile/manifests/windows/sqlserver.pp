# Class: profile::windows::sqlserver
#
#
class profile::windows::sqlserver {

  dsc_xmountimage { 'SQL Server ISO':
    dsc_ensure      => 'Present',
    dsc_imagepath   => 'C:\\users\\vagrant\\desktop\\sql\\en_sql_server_2016_developer_with_service_pack_1_x64_dvd_9548071.iso',
    dsc_driveletter => 'D',
  }

  dsc_xwaitforvolume { 'Wait for mounted SQL Server ISO':
    dsc_driveletter => 'D',
    require         => dsc_xmountimage['SQL Server ISO'],
  }

  dsc_xsqlserversetup { 'Install SQL Server':
    ensure                  => 'present',
    dsc_action              => 'Install',
    dsc_instancename        => 'MSSQLSERVER',
    # dsc_sourcepath        => 'E:\\' # supposed to be UNC i think..
    dsc_sourcepath          => 'D:\\',
    #dsc_sourcecredential   => {
    #     'user'     => $domain_administrator_user,
    #     'password' => $domain_administrator_password,
    # },
    dsc_suppressreboot      => false,
    dsc_forcereboot         => true,
    dsc_features            => 'SQLENGINE',
    # dsc_instanceid        => 'MSSQLSERVER',
    # dsc_productkey        => 'xxx-xxx-xxx-xxx'
    dsc_updateenabled       => 'true',
    #dsc_updatesource       => 'C:\\'
    dsc_sqmreporting        => 'true',
    dsc_errorreporting      => 'true',
    # dsc_installshareddir  => 'C:\\',
    # dsc_installsharedwowdir => 'C:\\',
    # dsc_InstanceDir => 'C:\\Program Files\\Microsoft SQL Server',
    # dsc_sqlsvcaccount   => {
    #     'user'     => $domain_administrator_user,
    #     'password' => $domain_administrator_password,
    # },
    # dsc_agtsvcaccount   => {
    #     'user'     => $domain_administrator_user,
    #     'password' => $domain_administrator_password,
    # },
    # dsc_sqlcollation => '',
    dsc_sqlsysadminaccounts => ['vagrant'],
    dsc_securitymode        => 'Windows', # 'SQL' aka mixed
    # dsc_sapwd             => 'XXXX' # only applicable if mixed security mode
    # dsc_installsqldatadir => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Data',
    # dsc_sdluserdbdir      => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Data',
    # dsc_sqluserdblogdir   => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Data',
    # dsc_sqltempdbdir      => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Data',
    # dsc_sqltempdblogdir     => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Data',
    # dsc_sqlbackupdir        => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Backup',
    # dsc_ftsvcaccount   => {
    #     'user'     => 'vagrant',
    #     'password' => 'vagrant',
    # },
    # dsc_rssvcaccount   => {
    #     'user'     => 'vagrant',
    #     'password' => 'vagrant',
    # },
    # dsc_assvcaccount   => {
    #     'user'     => 'vagrant',
    #     'password' => 'vagrant',
    # },
    # dsc_ascollation => 'SQL_Latin1_General_CP1_CI_AS',
    # dsc_assysadminaccounts => ['vagrant'],
    # dsc_asdatadir         => 'C:\\MSOLAP\\Data',
    # dsc_aslogdir          => 'C:\\MSOLAP\\Log',
    # dsc_asbackupdir       => 'C:\\MSOLAP\\Backup',
    # dsc_astempdir         => 'C:\\MSOLAP\\Temp',
    # dsc_asconfdir           =>  'C:\\MSOLAP\\Config',
    # dsc_issvcaccount   => {
    #     'user'     => 'vagrant',
    #     'password' => 'vagrant',
    # },
    # dsc_browsersvcstartuptype => 'Automatic',
    # dsc_failoverclustergroupname => 'SQL Server (MSSQLSERVER)',
    # dsc_failoverclusteripaddress => ['10.0.0.2', '10.0.0.3'],
    # dsc_failoverclusternetworkname => 'blah',
   # dsc_setupprocesstimeout => 7200, # 2 hours
    dsc_setupcredential     => {
        'user'     => 'vagrant',
        'password' => 'vagrant',
    },
  }
}