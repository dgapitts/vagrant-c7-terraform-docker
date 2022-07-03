## Demo002 switch nginx port via terraform

Continuing the [hashicorp basic training ("Change Infrastructure")](https://learn.hashicorp.com/tutorials/terraform/docker-change?in=terraform/docker-get-started)
```
[c7-master:root:~/learn-terraform-docker-container] # docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
dfaeee402012   55f4b40fe486   "/docker-entrypoint.…"   24 seconds ago   Up 23 seconds   0.0.0.0:8000->80/tcp   tutorial
```

we want to switch this to 8000

```
[c7-master:root:~/learn-terraform-docker-container] # diff main.tf main.tf.old
22c22
<     external = 8080
---
>     external = 8000
```

running `terraform plan` we can see the desired change

```

      ~ ports {
          ~ external = 8000 -> 8080 # forces replacement

```

i.e.

```
[c7-master:root:~/learn-terraform-docker-container] # time terraform plan
docker_image.nginx: Refreshing state... [id=sha256:55f4b40fe486a5b734b46bb7bf28f52fa31426bf23be068c8e7b19e58d9b8debnginx:latest]
docker_container.nginx: Refreshing state... [id=dfaeee4020126f84257023af447ab76285c5f1a908caf859360b133bf7cc222a]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # docker_container.nginx must be replaced
-/+ resource "docker_container" "nginx" {
      + bridge            = (known after apply)
      ~ command           = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> (known after apply)
      + container_logs    = (known after apply)
      - cpu_shares        = 0 -> null
      - dns               = [] -> null
      - dns_opts          = [] -> null
      - dns_search        = [] -> null
      ~ entrypoint        = [
          - "/docker-entrypoint.sh",
        ] -> (known after apply)
      ~ env               = [] -> (known after apply)
      + exit_code         = (known after apply)
      ~ gateway           = "172.17.0.1" -> (known after apply)
      - group_add         = [] -> null
      ~ hostname          = "dfaeee402012" -> (known after apply)
      ~ id                = "dfaeee4020126f84257023af447ab76285c5f1a908caf859360b133bf7cc222a" -> (known after apply)
      ~ init              = false -> (known after apply)
      ~ ip_address        = "172.17.0.2" -> (known after apply)
      ~ ip_prefix_length  = 16 -> (known after apply)
      ~ ipc_mode          = "private" -> (known after apply)
      - links             = [] -> null
      - log_opts          = {} -> null
      - max_retry_count   = 0 -> null
      - memory            = 0 -> null
      - memory_swap       = 0 -> null
        name              = "tutorial"
      ~ network_data      = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_address       = ""
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.2"
              - ip_prefix_length          = 16
              - ipv6_gateway              = ""
              - network_name              = "bridge"
            },
        ] -> (known after apply)
      - network_mode      = "default" -> null
      - privileged        = false -> null
      - publish_all_ports = false -> null
      ~ security_opts     = [] -> (known after apply)
      ~ shm_size          = 64 -> (known after apply)
      - sysctls           = {} -> null
      - tmpfs             = {} -> null
        # (12 unchanged attributes hidden)

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      ~ ports {
          ~ external = 8000 -> 8080 # forces replacement
            # (3 unchanged attributes hidden)
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

real	0m0.905s
user	0m0.708s
sys	0m0.098s
```

running `terraform apply`

```
```

```
[c7-master:root:~/learn-terraform-docker-container] # time terraform apply
docker_image.nginx: Refreshing state... [id=sha256:55f4b40fe486a5b734b46bb7bf28f52fa31426bf23be068c8e7b19e58d9b8debnginx:latest]
docker_container.nginx: Refreshing state... [id=dfaeee4020126f84257023af447ab76285c5f1a908caf859360b133bf7cc222a]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # docker_container.nginx must be replaced
-/+ resource "docker_container" "nginx" {
      + bridge            = (known after apply)
      ~ command           = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> (known after apply)
      + container_logs    = (known after apply)
      - cpu_shares        = 0 -> null
      - dns               = [] -> null
      - dns_opts          = [] -> null
      - dns_search        = [] -> null
      ~ entrypoint        = [
          - "/docker-entrypoint.sh",
        ] -> (known after apply)
      ~ env               = [] -> (known after apply)
      + exit_code         = (known after apply)
      ~ gateway           = "172.17.0.1" -> (known after apply)
      - group_add         = [] -> null
      ~ hostname          = "dfaeee402012" -> (known after apply)
      ~ id                = "dfaeee4020126f84257023af447ab76285c5f1a908caf859360b133bf7cc222a" -> (known after apply)
      ~ init              = false -> (known after apply)
      ~ ip_address        = "172.17.0.2" -> (known after apply)
      ~ ip_prefix_length  = 16 -> (known after apply)
      ~ ipc_mode          = "private" -> (known after apply)
      - links             = [] -> null
      - log_opts          = {} -> null
      - max_retry_count   = 0 -> null
      - memory            = 0 -> null
      - memory_swap       = 0 -> null
        name              = "tutorial"
      ~ network_data      = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_address       = ""
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.2"
              - ip_prefix_length          = 16
              - ipv6_gateway              = ""
              - network_name              = "bridge"
            },
        ] -> (known after apply)
      - network_mode      = "default" -> null
      - privileged        = false -> null
      - publish_all_ports = false -> null
      ~ security_opts     = [] -> (known after apply)
      ~ shm_size          = 64 -> (known after apply)
      - sysctls           = {} -> null
      - tmpfs             = {} -> null
        # (12 unchanged attributes hidden)

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      ~ ports {
          ~ external = 8000 -> 8080 # forces replacement
            # (3 unchanged attributes hidden)
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_container.nginx: Destroying... [id=dfaeee4020126f84257023af447ab76285c5f1a908caf859360b133bf7cc222a]
docker_container.nginx: Destruction complete after 0s
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=3b61d5e3032a18f1643ddf2e3962558f9bfeb4c8a386ffa790676c3d10bcb416]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

real	0m4.015s
user	0m0.893s
sys	0m0.127s
```

Finally checking via `docker ps`
````
[c7-master:root:~/learn-terraform-docker-container] # docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
3b61d5e3032a   55f4b40fe486   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:8080->80/tcp   tutorial
```