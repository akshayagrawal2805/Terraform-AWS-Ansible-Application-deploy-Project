# Terraform-AWS-Ansible-Application-deploy-Project
Using Terraform from local will create 2 EC2 instance and install ansible on one, then with ansible will manage a target server to deploy a nodejs application.

Part - 1

Step 1 ) Starting Point - (Installing Terraform) on my Local machine and Creating a AWS Free account for this project.
Install Terraform from the Downloads [Page](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
Once installed check the installation by running a " terraform --version " command

Step 2 ) Create an AWS Account and perform below steps  - 

Install AWS CLI (Command Line Interface):
Make sure you have the AWS CLI installed on your machine. You can download and install it from the AWS CLI download page.

Create an AWS IAM User:
To interact with AWS programmatically, you should create an IAM (Identity and Access Management) user with appropriate permissions. Here's how to create one:

a. Log in to the AWS Management Console with an account that has administrative privileges.

b. Navigate to the IAM service.

c. Click on "Users" in the left navigation pane and then click "Add user."

Choose a username, select "Programmatic access" as the access type, and click "Next: Permissions."

Attach policies to this user based on your requirements. At a minimum, you should attach the "AmazonEC2FullAccess" policy for basic EC2 operations. If you need access to other AWS services, attach the relevant policies accordingly.

Review the user's configuration and create the user. Be sure to save the Access Key ID and Secret Access Key that are displayed after user creation; you'll need these for Terraform.

Configure AWS CLI Credentials:
Use the AWS CLI to configure your credentials. Open a terminal and run:

aws configure
It will prompt you to enter your AWS Access Key ID, Secret Access Key, default region, and default output format. Enter the credentials you obtained in the previous step.

Step 3 ) Now lets create terraform files to start provisioning the infrastructure.

> For this project we need 2 EC2 instances naming (Ansible Server and Target Server) and one S3 Bucket to store our tfstate file.
> Before creating the terraform files we need to have 2 things key value pair to later connect with the EC2 instances and one S3 bucket. So, from the AWS console go to EC2 and in the left you'll find key-pair so create a key pair download it and you need to give its reference(main.tf) while creating EC2 through Terraform. Also create a general S3 bucket from console and we will be giving its reference in backend.tf file.
> So we will be creating following files for the project -

1.provider.tf 
2.main.tf
3.variable.tf
4.output.tf
5.backend.tf 

> I have saved the Reference files in Terraform folder under master branch.

Step 4 )

> Start with <terraform init> command, once terraform successfully intialize move ahead with second command <terraform plan>
> Terraform plan command will tell you exactly what we are creating, it is like a dry run which will tell you what is going to happen without actually executing it.
> Now run the terraform apply command to actual provision the infrastructure. Once created terraform will print the public IP of servers as instructed in output.tf file.

Part -2

Step 5 ) Check in AWS console if you can see your EC2 instances. Once done you can proceed with the part 2 of this project, which is configuiring ansible and enabling passwordless authentication between ansible and target server.

> To configure ansible first lets login to the ansible server. To login I have used mobaxterm, To connect with EC2 through mobaxterm you need to add the pem key file follow the below steps to do that - 

a) download mobaxterm home edition/ portable edition - ([url](https://mobaxterm.mobatek.net/download.html)) Download and complete the setup
b) once mobaxterm setup is done open it and click on SSH session. Give Public ip of the ansible server in remote host and ubunutu as username(if you have used ubuntu AMI image for EC2 creation), Then click on Advanced SSH setting > use private key > select your pem key (Keuy pair) which we created under step3. Once done click ok and connect.
c) once you are successfully logged in check if Ansible is installed in your server - ansible -version, if you see ansible command not found then install ansible by running following command - 
sudo apt update
sudo apt install ansible
ansible -v version
d) The above step you need to do for both the server - Ansible and Target server. Now to enable passwordless authentication run following command on both the server - 
<ssh-keygen>
e) This command will create a public and private key and another file with name authorized keys. Copy the public key of Ansible server and paste it in authorized key file in anisble server.
f) Now try to SSH to the private ip of Target server from Ansible server - ssh <private-ip-target-server> you'll be able to connect.

Part - 3

Step 6 ) Now to start the third part of the project deploying the application on the target server using Ansible from Ansible server.

> Lets start with creating a shell script which ansible will use to perform certain tasks on Target server.(reference can taken from deploy.sh file in terraform folder under master branch)
> Create a Ansible playbook to update tasks to be implemented on Target server (reference can taken from playbook.yaml file in terraform folder under master branch)
> the application code is here in master branch so we doing git clone of master branch in target server with ansible and deploying the application.
> once you get a message playbook completed or deployment complete you can try accessing the application:  <public-IP-target-server>:3000
> if it is not accessible don't worry you must need to setup inbound rule for target server in AWS security groups for port 3000. After that your application is accessible.

Note: With this project we are getting hands-on experience with Terraform, Ansible, SHell and AWS.
Note: There are lots of improvement needed in this Readme and in this repo. I am working on it and will update it with more information.
