# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 9000, host: 9090
  config.vm.synced_folder ".", "/vagrant", :nfs => true
  config.vm.network :private_network, type: "dhcp"

  config.vm.provision "docker" do |d|

     d.run "grunt-server",
      image: "schoeffman/dockerfun",
      args: "-p 9000:9000 -v /vagrant:/code"


     #docker run --name some-nginx -v /some/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx
     d.run "nginx",
      image: "nginx",
      args: "-p 9000:9000 -v /vagrant:/code"

  end
end
