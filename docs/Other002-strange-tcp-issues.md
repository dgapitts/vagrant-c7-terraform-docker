## Strange tcp looker errors

### Summary

This sort of issue(s) appears to be affecting many users, and there are lots of suggestions out there:
* I have tried a couple but they didn't work (notes below)
* The problems for me started when work on a public wifi network, my final solution was `vagrant destroy` and then rebuilt the machine where I'm running these terraform docker training examples.
 
### Background



Uggh, my project hit a wierd snag

```
[c7-master:root:~/learn-terraform-docker-container] # terraform apply

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Still creating... [10s elapsed]
╷
│ Error: Unable to read Docker image into resource: unable to pull image nginx:latest: error pulling image nginx:latest: Error response from daemon: Get "https://registry-1.docker.io/v2/": dial tcp: lookup registry-1.docker.io on 10.0.2.3:53: read udp 10.0.2.15:43372->10.0.2.3:53: i/o timeout
│ 
│   with docker_image.nginx,
│   on main.tf line 12, in resource "docker_image" "nginx":
│   12: resource "docker_image" "nginx" {
│ 
╵

```


One [stackoverflow suggestion](https://stackoverflow.com/questions/47580528/error-response-from-daemon-get-https-registry-1-docker-io-v2-dial-tcp-look) was to restart docker, unfortunately it didn't help.

The problems start after work on the train (public wifi) and so I also tried a host/vagrant stop and start... unfortunately this didn't help.

Another suggestion github issue based suggestion was to try [insecure_skip_verify=true](https://github.com/kreuzwerker/terraform-provider-docker/issues/135)

```
[c7-master:root:~/learn-terraform-docker-container] # cat main.tf
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {
  insecure_skip_verify=true
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```

again this didn't help


```
[c7-master:root:~/learn-terraform-docker-container] # terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider kreuzwerker/docker: could not connect to registry.terraform.io: Failed to request discovery document: Get
│ "https://registry.terraform.io/.well-known/terraform.json": dial tcp: lookup registry.terraform.io on 10.0.2.3:53: read udp 10.0.2.15:49940->10.0.2.3:53: i/o timeout
```╵

