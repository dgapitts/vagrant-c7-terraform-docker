# Demo005 - Query Data with Outputs

Continuing the [hashicorp basic training ("Query Data with Outputs")](https://learn.hashicorp.com/tutorials/terraform/docker-change?in=terraform/docker-get-started)

## Using outputs.tf

To start this exercise, we add the `outputs.tf` file


```
[c7-master:root:~/learcn-terraform-docker-container] # cat outputs.tf 
output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.id
}
```

jumping into (re)building but with this extra `outputs.tf` to capture key output parameters:

```
[c7-master:root:~/learn-terraform-docker-container] # terraform apply
docker_image.nginx: Refreshing state... [id=sha256:55f4b40fe486a5b734b46bb7bf28f52fa31426bf23be068c8e7b19e58d9b8debnginx:latest]
docker_container.nginx: Refreshing state... [id=30010093f47a08081282e9e95914a662fe7209baf23dee58edd411010fd6bc7d]

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
...
Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

container_id = "0fa727bc5d1fdf5aa71c9e2c2d144985db51aaef6fe0b6a146a3db70bb4b6db0"
image_id = "sha256:55f4b40fe486a5b734b46bb7bf28f52fa31426bf23be068c8e7b19e58d9b8debnginx:latest"
```


