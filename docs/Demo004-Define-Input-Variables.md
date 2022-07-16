# Demo004 - Define Input Variables

Continuing the [hashicorp basic training ("Define Input Variables")](https://learn.hashicorp.com/tutorials/terraform/docker-change?in=terraform/docker-get-started)

## Using variables defined in external file variables.tf

To start this exercise 
* in `main.tf` replace the hardcoded `name` from the string "tutorial" to the new variable `var.container_name`
* start a new `variables.tf` which defines `variable "container_name"`


```
[c7-master:root:~/learn-terraform-docker-container] # cp main.tf main.bak
[c7-master:root:~/learn-terraform-docker-container] # vi main.tf
[c7-master:root:~/learn-terraform-docker-container] # vi variables.tf
[c7-master:root:~/learn-terraform-docker-container] # diff main.tf main.bak
19c19
<   name  = var.container_name
---
>   name  = "tutorial"
[c7-master:root:~/learn-terraform-docker-container] # cat variables.tf 
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "ExampleNginxContainer"
}

```
and running this
```
[c7-master:root:~/learn-terraform-docker-container] # terraform apply
docker_image.nginx: Refreshing state... 

...

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
...
      + name             = "ExampleNginxContainer"
...

  Enter a value: yes

docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 0s [id=50921e52e3b05d60a342ea21a7409684fcc4ae0236f58f5d9a7b5bd046285287]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
and finally checking `docker ps` again
```
[c7-master:root:~/learn-terraform-docker-container] # docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
50921e52e3b0   55f4b40fe486   "/docker-entrypoint.…"   8 seconds ago   Up 6 seconds   0.0.0.0:8000->80/tcp   ExampleNginxContainer
```

## override variables.tf variables via terraform apply -var...

Next override the "container_name"
* above we read  `variables.tf` which defines `variable "container_name"`
* however next we `terraform apply` with `-var "container_name=YetAnotherName"`

```
[c7-master:root:~/learn-terraform-docker-container] # terraform apply -var "container_name=YetAnotherName"
docker_image.nginx: Refreshing state... 
...
      ~ name              = "ExampleNginxContainer" -> "YetAnotherName" # forces replacement
...
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 0s [id=30010093f47a08081282e9e95914a662fe7209baf23dee58edd411010fd6bc7d]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
```
and finally checking `docker ps` again
```
[c7-master:root:~/learn-terraform-docker-container] # docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS        PORTS                  NAMES
30010093f47a   55f4b40fe486   "/docker-entrypoint.…"   3 seconds ago   Up 1 second   0.0.0.0:8000->80/tcp   YetAnotherName
```

