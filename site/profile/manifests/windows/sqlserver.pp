# Class: profile::windows::sqlserver
#
#
class profile::windows::sqlserver {
  dsc_xsqlserversetup { 'Install SQL Server':
    ensure                  => 'present',
    dsc_action              => 'Install',
    dsc_instancename        => 'MSSQLSERVER',
    # dsc_sourcepath        => 'E:\\' # supposed to be UNC i think..
    dsc_sourcepath          => 'C:\\users\\vagrant\\desktop\\sql',
    #dsc_sourcecredential    => => {
    #     'user'     => $domain_administrator_user,
    #     'password' => $domain_administrator_password,
    # },
    dsc_suppressreboot      => false,
    dsc_forcereboot         => true,
    dsc_features            => 'SQLENGINE',
    # dsc_instanceid  => 'MSSQLSERVER',
    # dsc_productkey => 'xxx-xxx-xxx-xxx'
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
    dsc_sqltempdblogdir     => 'C:\\Program Files\\Microsoft SQL Server\\MSSQL13.MSSQLSERVER\\MSSQL\\Data',
    # dsc_setupcredential     => {
    #     'user'     => $domain_administrator_user,
    #     'password' => $domain_administrator_password,
    # },
  }
}