## `Cannot connect to the Docker daemon` ... `Is the docker daemon running?` ... extra alias for docker.service start | stop | status

After a `vagrant halt` / `vagrant up` I hit

```
[c7-master:root:~/learn-terraform-docker-container] # time terraform plan
╷
│ Error: Error pinging Docker server: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
│ 
│   with provider["registry.terraform.io/kreuzwerker/docker"],
│   on main.tf line 10, in provider "docker":
│   10: provider "docker" {}
│ 
╵

real	0m0.746s
user	0m0.669s
sys	0m0.076s
```

not surprising I need to periodically restart the docker.service around restarts on my centos7 (c7) server

```
alias docker-start='systemctl start docker'
alias docker-status='systemctl status docker'
alias docker-stop='systemctl stop docker'
```