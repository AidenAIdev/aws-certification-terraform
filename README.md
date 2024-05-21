## AWS Terraform Project for Web App Infrastructure

### Description

This Terraform project automates the provisioning of the infrastructure required for a web application on AWS. It creates the following resources:

- Virtual Private Cloud (VPC)
- Public and private subnets
- Internet Gateway
- Route tables and associations
- Security groups
- EC2 instances

The goal of this project is to provide a consistent and repeatable way to set up the necessary AWS resources for a web application, making it easier to manage and scale the infrastructure as needed.

### Dependencies

This project requires the following dependencies:

1. **Terraform**: The Infrastructure as Code (IaC) tool used to provision the AWS resources. You can download Terraform from the official website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

2. **AWS CLI**: The AWS Command Line Interface is used to authenticate with AWS and interact with the various services. You can install the AWS CLI from the official documentation: [https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

3. **AWS Account**: You'll need an active AWS account with the necessary permissions to create the resources defined in this project.

### Getting Started

1. **Clone the repository**: Start by cloning the repository to your local machine.

    ```bash
    git clone https://github.com/k1ngPig/aws-terraform-project.git
    ```

2. **Configure AWS Credentials**: Ensure that you have your AWS credentials (access key and secret key) set up on your local machine. You can do this by running the following command and following the prompts:

    ```bash
    aws configure
    ```

3. **Initialize Terraform**: Navigate to the project directory and run the following command to initialize Terraform:

    ```bash
    terraform init
    ```

4. **Plan the Infrastructure**: Run the following command to see the changes that Terraform will make to your AWS environment:

    ```bash
    terraform plan
    ```

5. **Apply the Changes**: If you're satisfied with the plan, apply the changes to create the infrastructure:

    ```bash
    terraform apply
    ```

6. **Verify the Resources**: After the apply process completes, you can check the AWS Management Console to ensure that the resources have been created as expected.

### Cleanup

When you're done with the project, you can destroy the resources by running the following command:

