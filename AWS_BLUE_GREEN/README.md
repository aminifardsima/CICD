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


Step:

Now we scale up the containers for customer to have 3 running containers we run the bellow code:

`aws ecs update-service --cluster microservices-serverlesscluster --service customer-microservice --desired-count 3`



account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com

  537  aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json
  538  ls
  539  cd deployment/
  540  ls
  541  aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json
  542  aws ecs describe-task-definition --task-definition customer-microservice
  543  aws ecs stop-task --cluster microservices-serverlesscluster --task customer
  544  aws ecs list-tasks --cluster microservices-serverlesscluster
  545  aws ecs list-tasks --cluster microservices-serverlesscluster -a
  546  aws ecs delete-service --cluster <cluster-name> --service <service-name> --force
  547  aws ecs delete-service --cluster microservices-serverlesscluster --service <service-name> --force
  548  aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json
  549  aws ecs create-service --service-name employee-microservice --cli-input-json file://create-employee-microservice-tg-two.json
  550  aws ecs list-tasks --cluster microservices-serverlesscluster
  551  voclabs:~/environment/deployment (dev) $ aws ecs list-tasks --cluster microservices-serverlesscluster
  552  {     "taskArns": [;         "arn:aws:ecs:us-east-1:523184819182:task/microservices-serverlesscluster/7aa5806d713e46b3b8144813a5456d85",;         "arn:aws:ecs:us-east-1:523184819182:task/microservices-serverlesscluster/7e6a73ffd5844191aa3675509ed85510";     ]; }
  553  aws ecs describe-tasks --cluster microservices-serverlesscluster --tasks 7aa5806d713e46b3b8144813a5456d85
  554  aws ecs execute-command --cluster microservices-serverlesscluster  --task 7aa5806d713e46b3b8144813a5456d85   --container customer   --interactive   --command "/bin/bash"
  555  cd ..
  556  ls
  557  cd environment/
  558  ls
  559  mkdir plugin
  560  cd plugin/
  561  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
  562  ls
  563  sudo yum install -y session-manager-plugin.rpm
  564  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
  565  aws ecs execute-command --cluster microservices-serverlesscluster  --task 7aa5806d713e46b3b8144813a5456d85   --container customer   --interactive   --command "/bin/bash"
  566  cd ..
  567  cd plugin/
  568  aws ecs describe-tasks --cluster microservices-serverlesscluster --tasks 7e6a73ffd5844191aa3675509ed85510
  569  ip a
  570  ls
  571  cd deployment/
  572  ls
  573  whoami 
  574  ls
  575  cd ~
  576  ld
  577  ls -al
  578  cd .ssh/
  579  ls
  580  cat authorized_keys 
  581  ls
  582  history




 
