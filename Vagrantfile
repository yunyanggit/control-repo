Vagrant.configure('2') do |config|
  config.pe_build.version = '2017.2.1'

  config.vm.define :puppetmaster do |node|
    node.vm.hostname = 'puppetmaster-001.local'
    node.vm.network :private_network, :ip => '10.20.1.2'
    node.vm.network "forwarded_port", guest: 8081, host: 8081
    node.vm.network "forwarded_port", guest: 8080, host: 8080
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.synced_folder ".", "/vagrant"
    node.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.linked_clone = true
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_bootstrap do |p|
      p.role = :master
    end

    node.vm.provision "shell", inline: <<-SHELL
          # disable firewall to allow access to enterprise console web ui
          sudo ufw disable

          # Setup puppet server to handle hiera-eyaml
          sudo /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
          sudo mkdir -p /etc/puppetlabs/puppet/keys/
          sudo cp /vagrant/keys/* /etc/puppetlabs/puppet/keys/
          sudo chown pe-puppet:pe-puppet /etc/puppetlabs/puppet/keys/*

          sudo puppet module install WhatsARanjit-node_manager --version 0.4.2
          sudo puppet apply /vagrant/PuppetMaster.pp --verbose
          
          sudo puppet agent --test
          sudo puppet agent --test

          # Automate first codemanager deploy
          sudo echo 'puppetlabs' | puppet access login --username admin
          puppet code deploy --all --wait
    SHELL
  end

  config.vm.define :windowsagent do |node|
    node.vm.hostname = 'windowsagent-001.local'
    node.vm.network :private_network, :ip => '10.20.1.3'
    node.vm.box = 'tragiccode/windows-2016-standard'
    node.vm.provider "virtualbox" do |v|
      v.linked_clone = true
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
    # node.vm.provision "shell", inline: <<-POWERSHELL
    # [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};
    # $webClient = New-Object System.Net.WebClient;
    # $webClient.DownloadFile('https://testmaster.local:8140/packages/current/install.ps1', 'install.ps1');
    # .\\install.ps1
    # POWERSHELL
  end

  config.vm.define :ubuntuagent do |node|
    node.vm.hostname = 'ubuntuagent-001.local'
    node.vm.network :private_network, :ip => '10.20.1.4'
    node.vm.network "forwarded_port", guest: 8000, host: 8000
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.provider "virtualbox" do |v|
      v.linked_clone = true
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end

  config.vm.define :splunkserver do |node|
    node.vm.hostname = 'splunkserver-001.local'
    node.vm.network :private_network, :ip => '10.20.1.5'
    node.vm.network "forwarded_port", guest: 8000, host: 8000
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.provider "virtualbox" do |v|
      v.linked_clone = true
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end

  config.vm.define :splunkforwarder do |node|
    node.vm.hostname = 'splunkforwarder-001'
    node.vm.network :private_network, :ip => '10.20.1.6'
    node.vm.box = 'tragiccode/windows-2016-standard'
    node.vm.provider "virtualbox" do |v|
      v.linked_clone = true
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end

  config.vm.define 'dc-001' do |node|
    node.vm.hostname = 'dc-001'
    node.vm.network :private_network, :ip => '10.20.1.7'
    node.vm.box = 'tragiccode/windows-2016-standard'
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.linked_clone = true
      v .customize ["modifyvm", :id, "--vram", 48]
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision "shell", inline: <<-POWERSHELL
    [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};
    $webClient = New-Object System.Net.WebClient;
    $webClient.DownloadFile('https://puppetmaster-001.local:8140/packages/current/install.ps1', 'install.ps1');
    .\\install.ps1
    POWERSHELL
  end

    config.vm.define 'dc-002' do |node|
    node.vm.hostname = 'dc-002'
    node.vm.network :private_network, :ip => '10.20.1.8'
    node.vm.box = 'tragiccode/windows-2016-standard'
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.linked_clone = true
      v .customize ["modifyvm", :id, "--vram", 48]
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision "shell", inline: <<-POWERSHELL
    [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};
    $webClient = New-Object System.Net.WebClient;
    $webClient.DownloadFile('https://puppetmaster-001.local:8140/packages/current/install.ps1', 'install.ps1');
    .\\install.ps1
    POWERSHELL
  end

    config.vm.define 'jenkinsmaster-001' do |node|
    node.vm.hostname = 'jenkinsmaster-001.local'
    node.vm.network :private_network, :ip => '10.20.1.9'
    # node.vm.network "forwarded_port", guest: 8000, host: 8000
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.provider "virtualbox" do |v|
      v.linked_clone = true
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end
end
