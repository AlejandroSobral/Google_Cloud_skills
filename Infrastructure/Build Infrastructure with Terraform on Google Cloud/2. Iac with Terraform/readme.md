## 2. Iac with Terraform

[Link](https://www.skills.google/course_templates/636/labs/592697)


Objectives:
- Build, change, and destroy infrastructure with Terraform.
- Create resource dependencies with Terraform.
- Provision infrastructure with Terraform.

----------------------

### Guide


Start by applying the 0_main.tf file, by doing:

```bash
alias t=terraform

student_00_f4d1380beda8@cloudshell:~ (qwiklabs-gcp-03-4b8b526e5de1)$ t plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_network.vpc_network will be created
  + resource "google_compute_network" "vpc_network" {
      + auto_create_subnetworks         = true
      + delete_default_routes_on_create = false
      + gateway_ipv4                    = (known after apply)
      + id                              = (known after apply)
      + ipv4_range                      = (known after apply)
      + name                            = "terraform-network"
      + project                         = (known after apply)
      + routing_mode                    = (known after apply)
      + self_link                       = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

t apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_network.vpc_network will be created
  + resource "google_compute_network" "vpc_network" {
      + auto_create_subnetworks         = true
      + delete_default_routes_on_create = false
      + gateway_ipv4                    = (known after apply)
      + id                              = (known after apply)
      + ipv4_range                      = (known after apply)
      + name                            = "terraform-network"
      + project                         = (known after apply)
      + routing_mode                    = (known after apply)
      + self_link                       = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_network.vpc_network: Creating...
google_compute_network.vpc_network: Still creating... [10s elapsed]
google_compute_network.vpc_network: Still creating... [20s elapsed]
google_compute_network.vpc_network: Creation complete after 26s [id=projects/qwiklabs-gcp-03-4b8b526e5de1/global/networks/terraform-network]
```

&nbsp;

Start by applying the 1_main.tf file, by doing "terraform apply".

Check the new VM instance created.

```
This resource includes a few more arguments. The name and machine type are simple strings, but boot_disk and network_interface are more complex blocks. Youcan see all of the available options in the google_compute_instance documentation.
For this example, your compute instance will use a Debian operating system, and will be connected to the VPC Network you created earlier. Notice how thisconfiguration refers to the network's name property with google_compute_network.vpc_network.name -- google_compute_network.vpc_network is the ID, matchingthe values in the block that defines the network, and name is a property of that resource.
The presence of the access_config block, even without any arguments, ensures that the instance is accessible over the internet.
```


Moving forward, apply the 2_main.tf. In this opportunity, destructive changes will occurr:
```
A destructive change is a change that requires the provider to replace the existing resource rather than updating it. This usually happens because the cloud provider doesn't support updating the resource in the way described by your configuration.
Changing the disk image of your instance is one example of a destructive change. In this section, you edit the boot_disk block inside the vm_instance resource in your configuration file main.tf with the help of Gemini Code Assist's Smart Actions.
```

To finish, try "terraform destroy".

```bash
student_00_f4d1380beda8@cloudshell:~ (qwiklabs-gcp-03-4b8b526e5de1)$ t destroy
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-03-4b8b526e5de1/global/networks/terraform-network]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-03-4b8b526e5de1/zones/us-west1-c/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # google_compute_instance.vm_instance will be destroyed
  - resource "google_compute_instance" "vm_instance" {
      - can_ip_forward       = false -> null
      - cpu_platform         = "Intel Broadwell" -> null
      - deletion_protection  = false -> null
      - enable_display       = false -> null
      - guest_accelerator    = [] -> null
      - id                   = "projects/qwiklabs-gcp-03-4b8b526e5de1/zones/us-west1-c/instances/terraform-instance" -> null
      - instance_id          = "2090021528444189093" -> null
      - label_fingerprint    = "42WmSpB8rSM=" -> null
      - labels               = {} -> null
      - machine_type         = "e2-micro" -> null
      - metadata             = {} -> null
      - metadata_fingerprint = "Nciri17EDQo=" -> null
      - name                 = "terraform-instance" -> null
      - project              = "qwiklabs-gcp-03-4b8b526e5de1" -> null
      - self_link            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-03-4b8b526e5de1/zones/us-west1-c/instances/terraform-instance" -> null
      - tags                 = [
          - "dev",
          - "web",
        ] -> null
      - tags_fingerprint     = "XaeQnaHMn9Y=" -> null
      - zone                 = "us-west1-c" -> null

      - boot_disk {
          - auto_delete = true -> null
          - device_name = "persistent-disk-0" -> null
          - mode        = "READ_WRITE" -> null
          - source      = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-03-4b8b526e5de1/zones/us-west1-c/disks/terraform-instance" -> null

          - initialize_params {
              - image  = "https://www.googleapis.com/compute/v1/projects/cos-cloud/global/images/cos-stable-121-18867-294-88" -> null
              - labels = {} -> null
              - size   = 10 -> null
              - type   = "pd-standard" -> null
            }
        }

      - network_interface {
          - name               = "nic0" -> null
          - network            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-03-4b8b526e5de1/global/networks/terraform-network" -> null
          - network_ip         = "10.138.0.3" -> null
          - subnetwork         = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-03-4b8b526e5de1/regions/us-west1/subnetworks/terraform-network" -> null
          - subnetwork_project = "qwiklabs-gcp-03-4b8b526e5de1" -> null

          - access_config {
              - nat_ip       = "136.118.188.141" -> null
              - network_tier = "PREMIUM" -> null
            }
        }

      - scheduling {
          - automatic_restart   = true -> null
          - on_host_maintenance = "MIGRATE" -> null
          - preemptible         = false -> null
        }

      - shielded_instance_config {
          - enable_integrity_monitoring = true -> null
          - enable_secure_boot          = false -> null
          - enable_vtpm                 = true -> null
        }
    }

  # google_compute_network.vpc_network will be destroyed
  - resource "google_compute_network" "vpc_network" {
      - auto_create_subnetworks         = true -> null
      - delete_default_routes_on_create = false -> null
      - id                              = "projects/qwiklabs-gcp-03-4b8b526e5de1/global/networks/terraform-network" -> null
      - name                            = "terraform-network" -> null
      - project                         = "qwiklabs-gcp-03-4b8b526e5de1" -> null
      - routing_mode                    = "REGIONAL" -> null
      - self_link                       = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-03-4b8b526e5de1/global/networks/terraform-network" -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.
```


### Resource implicit dependency

Real-world infrastructure has a diverse set of resources and resource types. Terraform configurations can contain multiple resources, multiple resource types, and these types can even span multiple providers.

In this section, you are shown a basic example of how to configure multiple resources and how to use resource attributes to configure other resources.

Using the 3_main.tf file, try:

```bash
# Get the plan
terraform plan -out static_ip

...
..
.
PLAN OUTPUT
.
..
...
# Apply the plan
terraform apply "static_ip"


google_compute_network.vpc_network: Creating...
google_compute_address.vm_static_ip: Creating...
google_compute_address.vm_static_ip: Creation complete after 5s [id=projects/qwiklabs-gcp-00-51282d8fe1ee/regions/europe-west1/addresses/terraform-static-ip]
google_compute_network.vpc_network: Still creating... [10s elapsed]
google_compute_network.vpc_network: Still creating... [20s elapsed]
google_compute_network.vpc_network: Still creating... [30s elapsed]
google_compute_network.vpc_network: Creation complete after 37s [id=projects/qwiklabs-gcp-00-51282d8fe1ee/global/networks/terraform-network]
google_compute_instance.vm_instance: Creating...
google_compute_instance.vm_instance: Still creating... [10s elapsed]
google_compute_instance.vm_instance: Creation complete after 19s [id=projects/qwiklabs-gcp-00-51282d8fe1ee/zones/europe-west1-b/instances/terraform-instance]
```

As shown above, Terraform created the static IP before modifying the VM instance. Due to the interpolation expression that passes the IP address to the instance's network interface configuration, Terraform is able to infer a dependency, and knows it must create the static IP before updating the instance.

### Resource explicit dependency

Sometimes there are dependencies between resources that are not visible to Terraform. The depends_on argument can be added to any resource and accepts a list of resources to create explicit dependencies for.


Using the 4_main.tf file, try:

```bash
terraform plan
...
..
.
PLAN OUTPUT
.
..
...

terraform apply
```

### Define a provisioner

The compute instance you launched at this point is based on the Google image given, but has no additional software installed or configuration applied.

Google Cloud allows customers to manage their own custom operating system images. This can be a great way to ensure that the instances you provision with Terraform are pre-configured based on your needs. Packer is the perfect tool for this and includes a builder for Google Cloud.

Terraform uses provisioners to upload files, run shell scripts, or install and trigger other software like configuration management tools.

&nbsp;

Move ahead an apply 5_main.tf where a provisioner was included.

Terraform found nothing to do - and if you check, you'll find that there's no ip_address.txt file on your local machine.

Terraform treats provisioners differently from other arguments. Provisioners only run when a resource is created, but adding a provisioner does not force that resource to be destroyed and recreated.

```bash
terraform taint google_compute_instance.vm_instance

terraform apply
```

Verify everything worked by looking at the contents of the ip_address.txt file:

```
terraform-instance: 35.233.64.167
```
