### Build Infrastructure with Terraform on Google Cloud: Challenge Lab

[Link](https://www.skills.google/course_templates/636/labs/592700)

[Badge](https://www.credly.com/badges/d9d08540-6050-4f9e-8195-427d6623738b/public_url)


Topics tested:
- Import existing infrastructure into your Terraform configuration.
- Build and reference your own Terraform modules.
- Add a remote backend to your configuration.
- Use and implement a module from the Terraform Registry.
- Re-provision, destroy, and update infrastructure.
- Test connectivity between the resources you've created.


###

To have it handy:

terraform import docker_container.web $(docker inspect -f {{.ID}} hashicorp-learn)
terraform show -no-color > docker.tf


## Task 1: Create the configuration files

Create the following structure whether manually of with the following bash script:

```
main.tf
variables.tf
modules/
└── instances
    ├── instances.tf
    ├── outputs.tf
    └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf
```

```bash
#!/bin/bash

# Create the root files
touch main.tf variables.tf

# Create the instances module directory and files
mkdir -p modules/instances
touch modules/instances/{instances.tf,outputs.tf,variables.tf}

# Create the storage module directory and files
mkdir -p modules/storage
touch modules/storage/{storage.tf,outputs.tf,variables.tf}

echo "Terraform directory structure created successfully!"
```

Set main & variables files as it has been done in Task1. Execute terraform init.


## Task 2. Import infrastructure

Navigate to Compute Engine > VM Instances. Copy the ID of both instances and have it handy.

First, add the module reference into the main.tf file then re-initialize Terraform. (Check main.tf in Task2).

Then proceed to import the instances as below:

```bash
terraform import module.instances.google_compute_instance.tf-instance-1 <INSTANCE-ID>
terraform import module.instances.google_compute_instance.tf-instance-2 <INSTANCE-ID-2>
```

The two instances have now been imported into your terraform configuration. You can now optionally run the commands to update the state of Terraform. Type yes at the dialogue after you run the apply command to accept the state changes.

```bash
terraform plan
terraform apply
```

## Task 3. Configure a remote backend

Create the Cloud Storage inside the storage module, add the reference in main and apply.
Configure the remote storage in the main.
Re-initiate terraform.


## Task 4. Modify and update infrastructure

Navigate to the instances module and modify the tf-instance-1 resource to use an e2-standard-2 machine type.
Modify the tf-instance-2 resource to use an e2-standard-2 machine type.

Add a third instance resource and name it Instance Name. For this third resource, use an e2-standard-2 machine type. Make sure to change the machine type to e2-standard-2 to all the three instances.
Then, do terraform apply.

## Task 5. Destroy resources

Remove the third instance and do apply once again.

## Task 6. Use the Terraform Registry.

Browse to the registry, pick a vpc and modify the given parameters.

## Task 7. Include a firewall.

Add a firewall to the network. Type is: google_compute_firewall



