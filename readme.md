# ECS Cluster with Fargate Launch type 
* this is a build up on similar project i did using EC2 launch config. 
* but this project was linited to: 
1. VPC with a 2 public subnet and 2 private subnets 
2. each subnet are in each AZ ie. 2a & 2b. thus public subnet 1 is in AZ 2a and publics subnet 2 is in AZ 2b. Same goes for the  Private subnet. 
#this will help the The DB subnet group to meet Availability Zone (AZ) coverage requirement
3. An application load balancer, target group and alb http listener
4. Internet Gateway to contact the outer world. Elastic IP address, Nat Gateway
5. RDS MySQL 


View previous project : Repo: https://github.com/IssifuM/ECS-EC2LAUNCHCONFIG-WITHTERRAFORM.git

# Consent: 
This repo can be used to deploy an ECS cluster with Fargate launch type on Terraform. 

# Variable.tf
Using a variable.tf file makes it easy for this project to be reaused. 
* Changes can easily be made in the variable.tf. Thus, you can make changes such as CIDR values for VPC, Availability zones, Region, port app etc.  
* Customize to suit your requirements. 

# Prerequisites for this to work correctly:
1. An AWS account configured to your local envirionment. 
2. If you are using IAM User's credential, it should have permission to make changes/manage all resources using terraform.
3. Terraform installed on your local machine
4. Visual Code installedon you machine



## Clone this Repo and Change Into That Directory
# the steps below was summarized from this link: https://techobservatory.com/how-to-clone-a-github-repository-in-visual-studio-code/ . Visit for more details.  
1. Get the code of the repo use what to clone. This can either be https or ssh. Personally I prefer https. 
2. open VScode. 
3. Select source control. 
4. select lone repository. 
5. paste https link in command pallete. 
6. Select directory where you want to save your clone. 
7. Click open. 



# Terraform Commands
1. First Run 'terraform init' on terminal to initialize a working directory containing Terraform configuration files
2. use 'terraform fmt' to rewrite/ arrange the code to an Terraform standard 
3. use 'terraform validate' make sure everything is valid 
4. use 'terraform plan' will give tell you all the resources you are about to create
5. use 'terraform apply' to provision your resources
6. use 'terraform destroy'  to destroy the resources created 



# .gitignore
Use .gitignore file to ignore the secrete .tfvars file.

