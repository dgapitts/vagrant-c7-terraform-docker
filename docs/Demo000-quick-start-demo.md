## Demo000 Quick start demo

Run 
* `vagrant up` to build the VM (you will need vagrant and virtualbox pre-installed)
* `vagrant ssh` to connect
* then `sudo -i` to connect as root, and as per the following, quick start demo ([full log here](quick-start-demo.log)) just run
```
[c7-master:root:~/learn-terraform-docker-container] # history
    1  cd learn-terraform-docker-container/
    2  time terraform init
    3  time terraform plan
    4  time terraform apply
    5  docker ps
    6  history
```
