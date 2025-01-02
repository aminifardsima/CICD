Two websites one works as Employee and the other one works as customer exist. In this project. atfirst we want to dockerize them and make images from each of them. then images will be pushed into
AWS ECS then Pipelines will be created to apply BLUE GREEN update. 
Step1:
apply these codes to make folders. 
`mikdir microservices`
`mkdir customer`
`mkdir employee`

Then we copy all of the files exist in Microservices path.

`git init`

`git branch -m dev`

`git add .`

`git commit -m 'Description'`

`git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices`

`git push -u origin dev`

`git config --global user.name "Your_imaginary_email_address"`

`docker build --tag employee .`

`docker build --tag customer .`

then we add the Docker file in order to make an image from custumer and employee.
then inside each of the folders we apply this command `docker build --tag customer .`
now we have made two images
STEP2:
in this step we puch images into  AWS ECR:

`aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com`

`account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)`

`docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest`

`dbEndpoint=$(cat ~/environment/microservices/customer/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)`



STEP3: log in to ECR( we get log in to our repository in AWS)

`dbEndpoint=$(cat ~/environment/microservices/employee/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)`

`account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)`

`aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com`

Now we tag each image already have:

`docker tag customer:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/customer:latest`

`docker tag employee:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest`


Now we send each image to ECR:

`docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/customer:latest`

`docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest`

`git add .` 

`git commit -m 'two unmodified copies of the application code'`

`git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices`

`git push -u origin dev`


Now we make a task inside our ECS cluster

`aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"`


`aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-employee.json"`

`git add .`

`git commit -m 'two unmodified copies of the application code'`

`git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices`

`git push -u origin dev`

`git commit -m 'deploymentcommited'`

now we make a repository named deployment inside code commit.

`git remote add origin  https://git-codecommit.us-east-1.amazonaws.com/v1/repos/deployment`

`git push -u origin dev`

`touch create-customer-microservice-tg-two.json`

`aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json`

`touch create-employee-microservice-tg-two.json`

`aws ecs create-service --service-name employee-microservice --cli-input-json file://create-employee-microservice-tg-two.json`

Now repeat the steps for employee

`dbEndpoint=$(cat ~/environment/microservices/employee/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)`

`account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)`

`docker tag employee:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest`

`aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com`

`docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest`


Step4:

Now we scale up the containers for customer to have 3 running containers we run the bellow code:

`aws ecs update-service --cluster microservices-serverlesscluster --service customer-microservice --desired-count 3`


Now in order to log in to our Aws:

`account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)`

`aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com`


if we want to make a service we run this code 


`aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json`


in order to see which container has cotten which ip and they belong to which task we run the bellow command: 
  
`aws ecs list-tasks --cluster microservices-serverlesscluster -a`
  


if we want to see the detail of the task :

```aws ecs describe-tasks --cluster microservices-serverlesscluster --tasks 7aa5806d713e46b3b8144813a5456d85```

I



 
