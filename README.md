# Introduction
The Goal of this repository is to provide the ability to quickly spin up a puppet enterprise environment for quickly testing changes without having to touch your actual puppet enterprise server.


# Requirements
1.) Install Vagrant

2.) Install Vagrant plugins
> vagrant plugin install vagrant-pe_build
> vagrant plugin install vagrant-hosts

3.) Download The version of puppet enterprise you would like to use
> Invoke-RestMethod -Method Get -Uri https://s3.amazonaws.com/pe-builds/released/2017.2.1/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz -OutFile ~/Downloads/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz
> vagrant pe-build copy file://C:/Users/tragiccode/Downloads/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz
NOTE: file://~/Downloads/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz might work


# Using Code Manager
1.) Install Pe-Client tools on your local workstation
2.) Run the following to quickly configure PE Client tools
> Configure-PEClientTools.ps1
2.) Update your hosts file to have the following entry
10.20.1.2     puppetmaster.local
3.) Obtain a RBAC token so you can deploy environments

> puppet-access login --username admin

4.) Initiate a deployment of all environments

> puppet-code print-config
> puppet-code status
> puppet-code deploy --all --wait --log-level info


# Using Eyaml
First you will need to generate some encryption keys.  Simply run the following command

```powershell
    > bundle exec eyaml createkeys
```


The content you want encrypted should live in a file with the .eyaml extension.  It should intially have the unencrypted value wrapped in some markers eyaml expects to find

Example
```
---
password: DEC::PKCS7[my super secret password here]!
```

Next you can encrypt the content of a string utilizing eyaml cli
```powershell
    > bundle exec eyaml encrypt -s 'hello there bob!'
```

```data/secure.eyaml
password: >
    ENC[PKCS7,MIIBiQYJKoZIhvcNAQcDoIIBejCCAXYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEAXjA0MbZ/x+iZOnAyklysIZeYiielyRuukTPL
    CvyqKiWBWMJD3Cu3tC6N2wfjqxZ2sK/yGZqduYqamKfKx5Y7uxu3su7l/FWa
    1eyqXfM/l+KQi2RJTTYjWtg+pg+uUejN9X9tpB6zjp8yjHHTpPaRTix/9tDW
    uyGR+cbLYIXiHXhLNZ5X7CvaiBDbVSQdfkwt4/eCHJuCkrzNZ0C6FlP94610
    mMLAI345hRa/Auiwtxy0qfpKCDIrpBczEqgMZDhnJ/0tLEu4P70Uy7t08A2A
    8I+d/IyRjhoHWfOvuNH3rbwBBoqAFfTLhSb4xd+jMDYWR931PB3V3mKo6c5J
    VpeanDBMBgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBSoYEAbjrkCBjKEXOc
    x1a/gCCF1KRi3NMVcCErYP0RA6HgTvR51dIFnx67MeDQHNr9oA==]
```

To decrypt the eyaml file and view the contents from the command line run the following
```powershell
    > bundle exec eyaml decrypt -e .\data\secure.eyaml
```

```decrypted output
    ---
password: >
  DEC::PKCS7[hello there bob!]!
```