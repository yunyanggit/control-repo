# Class: profile::activedirectory::organizationalunits
#
#
class profile::activedirectory::organizationalunits(

) {

  dsc_xadorganizationalunit { 'Domain Controllers':
    dsc_ensure      => 'present',
    dsc_name        => 'Domain Controllers',
    dsc_path        => 'DC=gccthd,DC=com',
    dsc_description => 'Managed by Puppet! Changes made manually may be lost.',
  }
}
