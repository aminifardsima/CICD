
# Building Microservices and a CI/CD Pipeline wih AWS ![Static Badge](https://img.shields.io/badge/Pipelne-AWS-red)
![fist pic ](Diagram.svg)
Overall explanation: This graph shows two layers. one is the network layer and another one shows service layer. Networking layer is the graphs inside VPc and service layer is the graph above that .  Although the service layer is drawn outside the VPc, all of the services are applying in the VPC LAB too. these two layers are connected to one another by LOAD BALANCER, which also has the responsibility of  the distribution of the loads.

**1)** Amazon ECR The latest Docker images generated via the build process are stored in Amazon ECR and pulled for
deployment in Fargate based on the developer changes to the source code (see step 13) in Fargate,
and they run across multiple Availability Zones for high availability (HA) with the latest version

**2)** AWS CodeCommit is a fully managed service that acts as a repository for storing application code whenever
the developer modifies or commits the code.

**3)** AWS CodePipeline is used to create an end-to-end pipeline that fetches the application code from
CodeCommit, builds and tests using CodeBuild, and finally deploys using CodeDeploy from
Amazon Elastic Container Registry (Amazon ECR) to the Fargate serverless platform for handling
user traffic.

**4)** AWS CodeDeploy is a fully-managed deployment service that automates software deployments to
AWS Fargate. The deployments contain the code or application (associated to new features to be
deployed based on developer changes) running CodeDeploy agents.


**5)** Amazon ECS on AWS Fargate connects to Amazon ECR via Amazon VPC by configuring ECR to use
an interface Amazon VPC endpoint. Amazon VPC interface endpoints enable private access to ECR
APIs through private IP addresses. AWS PrivateLink restricts all network traffic between the
Amazon VPC and ECR using the Amazon network.

**6)** NAT Gateway


**7)** APPLICATION Load Balancer (ALB) in the seven layer of the networking. if the path ends in /admin/*  traffic goes into the employee microservice otherwise the traffic goes into customer microservices. Also, it applies the strategy of blue/green.

**8)** Security group, controls which traffics are allowed to enter each subnets.

**9)** RDS,one relational database is runng in two private subnets.

**10)** containers are created by microservices that are runing inside Amazon ECS. When customer service is scaled up, 3 containers for customer will be created (as it is needed) .
**11)** IAM ROLE each user has its own access to the services by the policy that is defined in IAM ROLE.

**12)** Cloud watch logs. it keeps the record of logs in the whole process.
**13)** Cloud 9 has access to all services in the same VPC.





## Table of Contents
  - [Installation](#installation)
    - [STEP 1](#step-1)
    - [STEP 2](#step-2)
    - [STEP 3](#step-3)
    - [STEP 4](#step-4)






## Installation
> Two websites one works as Employee and the other one works as customer exist. In this project. At first we want to dockerize them and make images from each of them.
>  then images will be pushed into AWS ECS then Pipelines will be created to apply BLUE GREEN update.
### STEP 1:
Apply these codes to make folders.
```bash
mikdir microservices
mkdir customer
mkdir employee
```

Then we copy all of the files exist in Microservices path.
```bash
git init
git branch -m dev
git add .
git commit -m 'Description'
git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices
git push -u origin dev
git config --global user.name "Your_imaginary_email_address"
docker build --tag employee .
docker build --tag customer .
```
Then we add the Docker file in order to make an image from custumer and employee.
then inside each of the folders we apply this command `docker build --tag customer .`
now we have made two images.


### STEP 2:
In this step we puch images into  AWS ECR:
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com

account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)

docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest

dbEndpoint=$(cat ~/environment/microservices/customer/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)
```
### STEP 3:
Log in to ECR( we get log in to our repository in AWS)
```bash
dbEndpoint=$(cat ~/environment/microservices/employee/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)

account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com
```
Now we tag each image already have:
```bash
docker tag customer:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/customer:latest

docker tag employee:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest
```

Now we send each image to ECR:
```bash
docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/customer:latest
docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest

git add .
git commit -m 'two unmodified copies of the application code'
git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices
git push -u origin dev
```
Now we make a task inside our ECS cluster
```bash
aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-employee.json"

git add .
git commit -m 'two unmodified copies of the application code'
git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices
git push -u origin dev
git commit -m 'deploymentcommited'
```
Now we make a repository named deployment inside code commit.
```bash
git remote add origin  https://git-codecommit.us-east-1.amazonaws.com/v1/repos/deployment
git push -u origin dev

touch create-customer-microservice-tg-two.json
aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json

touch create-employee-microservice-tg-two.json
aws ecs create-service --service-name employee-microservice --cli-input-json file://create-employee-microservice-tg-two.json
```
Now repeat the steps for employee
```bash
dbEndpoint=$(cat ~/environment/microservices/employee/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)

account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
docker tag employee:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com
docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest
```
### STEP 4:
Now we scale up the containers for customer to have 3 running containers we run the bellow code:
```bash
aws ecs update-service --cluster microservices-serverlesscluster --service customer-microservice --desired-count 3
```
Now in order to log in to our Aws:
```bash
account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com
```
if we want to make a service we run this code

```bash
aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json
```
in order to see which container has cotten which ip and they belong to which task we run the bellow command:
```bash
aws ecs list-tasks --cluster microservices-serverlesscluster -a
```
if we want to see the detail of the task :
```bash
aws ecs describe-tasks --cluster microservices-serverlesscluster --tasks 7aa5806d713e46b3b8144813a5456d85
```
