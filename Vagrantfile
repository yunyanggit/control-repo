Vagrant.configure('2') do |config|
  config.pe_build.version = '2017.1.1'

  config.vm.define :puppetmaster do |node|
    node.vm.hostname = 'puppetmaster.local'
    node.vm.network :private_network, :ip => '10.20.1.2'
    node.vm.network "forwarded_port", guest: 8081, host: 8081
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.synced_folder ".", "/vagrant"
    node.vm.provider "virtualbox" do |v|
      v.memory = 4096
    end
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_bootstrap do |p|
      p.role = :master
    end
# sudo chmod 777 /etc/puppetlabs/code/environments/production/scripts/config_version.sh
    node.vm.provision "shell", inline: <<-SHELL
          sudo ufw disable
          sudo puppet module install WhatsARanjit-node_manager --version 0.4.1
          sudo puppet apply /vagrant/PuppetMaster.pp --verbose
          sudo puppet agent --test
          sudo puppet agent --test
          sudo r10k deploy environment -pv
    SHELL
  end

  config.vm.define :windowsagent do |node|
    node.vm.hostname = 'windowsagent.local'
    node.vm.network :private_network, :ip => '10.20.1.3'
    node.vm.box = 'mwrock/Windows2012R2'
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
    node.vm.hostname = 'ubuntuagent.local'
    node.vm.network :private_network, :ip => '10.20.1.4'
    node.vm.network "forwarded_port", guest: 8000, host: 8000
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end

  config.vm.define :splunkserver do |node|
    node.vm.hostname = 'splunkserver.local'
    node.vm.network :private_network, :ip => '10.20.1.5'
    node.vm.network "forwarded_port", guest: 8000, host: 8000
    node.vm.box = 'puppetlabs/ubuntu-16.04-64-nocm'
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end

  config.vm.define :splunkforwarder do |node|
    node.vm.hostname = 'splunkforwarder'
    node.vm.network :private_network, :ip => '10.20.1.6'
    node.vm.box = 'mwrock/Windows2012R2'
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end

  config.vm.define :domaincontroller do |node|
    node.vm.hostname = 'domaincontroller'
    node.vm.network :private_network, :ip => '10.20.1.7'
    node.vm.box = 'mwrock/Windows2012R2'
    node.vm.provision :hosts, :sync_hosts => true
    node.vm.provision :pe_agent do |p|
      p.master_vm = 'puppetmaster'
    end
  end
end
