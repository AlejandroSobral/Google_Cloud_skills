### 3. Interact with Terraform Modules

[Link](https://www.skills.google/course_templates/636/labs/592698)

Objectives:

- Use a module from the Registry.
- Build a module.

### What are modules for?
Here are some of the ways that modules help solve the problems listed above:

Organize configuration: Modules make it easier to navigate, understand, and update your configuration by keeping related parts of your configuration together. Even moderately complex infrastructure can require hundreds or thousands of lines of configuration to implement. By using modules, you can organize your configuration into logical components.

Encapsulate configuration: Another benefit of using modules is to encapsulate configuration into distinct logical components. Encapsulation can help prevent unintended consequences—such as a change to one part of your configuration accidentally causing changes to other infrastructure—and reduce the chances of simple errors like using the same name for two different resources.

Re-use configuration: Writing all of your configuration without using existing code can be time-consuming and error-prone. Using modules can save time and reduce costly errors by re-using configuration written either by yourself, other members of your team, or other Terraform practitioners who have published modules for you to use. You can also share modules that you have written with your team or the general public, giving them the benefit of your hard work.

Provide consistency and ensure best practices: Modules also help to provide consistency in your configurations. Consistency makes complex configurations easier to understand, and it also helps to ensure that best practices are applied across all of your configuration. For example, cloud providers offer many options for configuring object storage services, such as Amazon S3 (Simple Storage Service) or Google's Cloud Storage buckets. Many high-profile security incidents have involved incorrectly secured object storage, and because of the number of complex configuration options involved, it's easy to accidentally misconfigure these services.

Using modules can help reduce these errors. For example, you might create a module to describe how all of your organization's public website buckets are configured, and another module for private buckets used for logging applications. Also, if a configuration for a type of resource needs to be updated, using modules allows you to make that update in a single place and have it be applied to all cases where you use that module.

-----------------------------------------------------------------------


## Guide:

### Task 1. Use modules from the Registry

Open the [Terraform Registry](https://registry.terraform.io/modules/terraform-google-modules/network/google/3.3.0)

To start, run the following commands in Cloud Shell to clone the example simple project from the Google Terraform modules GitHub repository and switch to the v6.0.1 branch:

```bash
git clone https://github.com/terraform-google-modules/terraform-google-network
cd terraform-google-network
git checkout tags/v6.0.1 -b v6.0.1
```

Check main.tf, module "test-vpc-module" defines a Virtual Private Cloud (VPC), which provides networking services for the rest of your infrastructure.

Within the module "test-vpc-module" block, review the input variables you are setting. Each of these input variables is documented in the Terraform Registry. The required inputs for this module are:

- network_name: The name of the network being created
- project_id: The ID of the project where this VPC is created
- subnets: The list of subnets being created


Check the content of variables.tf to set the variables accordingly.

Modules also have output values, which are defined within the module with the output keyword. You can access them by referring to module.<MODULE NAME>.<OUTPUT NAME>. Like input variables, module outputs are listed under the outputs tab in the Terraform Registry.


Browse to the corresponding directory and apply the Terraform plan:

Expected output:
```bash
Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + network_name             = "example-vpc"
  + network_self_link        = (known after apply)
  + project_id               = "qwiklabs-gcp-00-3193aafef74f"
  + route_names              = []
  + subnets_flow_logs        = [
      + false,
      + true,
      + true,
    ]
  + subnets_ips              = [
      + "10.10.10.0/24",
      + "10.10.20.0/24",
      + "10.10.30.0/24",
    ]
  + subnets_names            = [
      + "subnet-01",
      + "subnet-02",
      + "subnet-03",
    ]
  + subnets_private_access   = [
      + false,
      + true,
      + false,
    ]
  + subnets_regions          = [
      + "europe-west4",
      + "europe-west4",
      + "europe-west4",
    ]
  + subnets_secondary_ranges = [
      + [],
      + [],
      + [],
    ]
```


### Module structure
Terraform treats any local directory referenced in the source argument of a module block as a module. 
A typical file structure for a new module is:

```bash
├── LICENSE
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```


Be aware of these files and ensure that you don't distribute them as part of your module:

- terraform.tfstate and terraform.tfstate.backup files contain your Terraform state and are how Terraform keeps track of the relationship between your configuration and the infrastructure provisioned by it.
- The .terraform directory contains the modules and plugins used to provision your infrastructure. These files are specific to an individual instance of Terraform when provisioning infrastructure, not the configuration of the infrastructure defined in .tf files.
- *.tfvarsfiles don't need to be distributed with your module unless you are also using it as a standalone Terraform configuration because module input variables are set via arguments to the module block in your configuration.

Follow the instructions:

![alt text](image.png)