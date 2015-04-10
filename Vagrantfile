# vi: set ft=ruby :

#auto install required plugins
required_plugins = %w( vagrant-hostmanager )
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(2) do |config|
 
  #Image type Ubuntu 14.04 
  config.vm.box = "ubuntu/trusty64"

  #Private ip to map out domain too
  config.vm.network "private_network", ip: "10.11.12.13"
  
  #Host manager plugin config
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.hostmanager.aliases = %w(vmobile.smgdigitaldev.com vagrant.smgdigitaldev.com)

  #port mappings
  config.vm.network "forwarded_port", guest: 80, host: 80 
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.network "forwarded_port", guest: 35729, host: 35729

  #use the network file system as it's faster
  config.vm.synced_folder ".", "/vagrant", :nfs => true

  config.vm.provision "docker" do |d|

     #Run our grunt server
     d.run "grunt-server",
      image: "schoeffman/grunt",
      args: "-p 9000:9000 \
             -p 35729:35729 \
             -v /vagrant:/code"

     #Use nginx as a reverse proxy
     d.run "nginx",
      image: "schoeffman/nginx",
      args: "-p 80:80 \
             -v /vagrant/mobilefe/nginx/docker/nginx.conf:/etc/nginx/nginx.conf \
             -v /vagrant/mobilefe/nginx/docker/sites-enabled:/etc/nginx/sites-enabled \
             --link grunt-server:grunt-server-link"

  end

end

#docker run -d --link CONTAINER:ALIAS --name LINKED user/wordpress
#docker run --name nginx -P --link grunt-server:app -v /vagrant/scripts/nginx.conf:/etc/nginx/nginx.conf -v /vagrant/scripts/sites-enabled:/etc/nginx/sites-enabled -i -t schoeffman/nginx /bin/bash
#docker run -P --link grunt-server:grunt -v /vagrant/scripts/nginx.conf:/etc/nginx/nginx.conf -v /vagrant/scripts/sites-enabled:/etc/nginx/sites-enabled -i -t schoeffman/nginx echo -e "upstream mobileapp { server 127.0.0.1:$APP_PORT_9000_TCP_PORT; }\n$(cat /etc/nginx/sites-enabled/mobile.smgdigitaldev.com)" > /etc/nginx/sites-enabled/mmobile.smgdigitaldev.com

