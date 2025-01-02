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
git status
  419  git add .
  420  git commit -m 'two unmodified copies of the application code'
  421  git push origin dev
  422  cd /home/ec2-user/environment/microservices/employee/
  423  ls
  424  dbEndpoint=$(cat ~/environment/microservices/employee/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)
  425  docker run -d --name employee_1 -p 8080:8080 -e APP_DB_HOST="$dbEndpoint" employee
  426  docker ps
  427  docker stop 2e7bd09d7430
  428  docker run -d --name employee_1 -p 8080:8080 -e APP_DB_HOST="$dbEndpoint" employee
  429  docker ps
  430  docker ps -a
  431  docker prune 0f956f53a4ab
  432  docker rm 0f956f53a4ab
  433  docker ps -a
  434  docker run -d --name employee_1 -p 8080:8080 -e APP_DB_HOST="$dbEndpoint" employee
  435  docker ps 
  436  git status
  437  git add .
  438  git commit -m 'two unmodified copies of the application code'
  439  git push origin dev
  440  cd .
  441  cd ..
  442  account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
  443  echo $account_id 
  444  aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com
  445  account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
  446  echo $account_id
  447  docker tag customer:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/customer:latest
  448  docker tag employee:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest
  449  docker images
  450  docker images -a
  451  account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
  452  docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/customer:latest
  453  docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest
  454  cd ..
  455  ls
  456  cd deployment/
  457  ls -a
  458  rm -rf .git/
  459  ls
  460  ls -s
  461  ls -a
  462  git init
  463   git branch -m dev
  464  git add .
  465  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  466  ls
  467  rm -f create-*
  468  ls
  469  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  470  OBclwear
  471  clear
  472  ls
  473  cd deployment/
  474  ls
  475  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  476  cd deployment/
  477  ls
  478  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  479  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-employee.json"
  480  history
  481    406  git init 
  482    407  git branch -m dev
  483    408  git add .
  484    409  git commit -m 'two unmodified copies of the application code'
  485    410  git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/microservices
  486    411  git push -u origin dev
  487  git init
  488  git branch -m dev
  489  git add .
  490  git commit -m 'deploymentcommited'
  491  git remote add origin  https://git-codecommit.us-east-1.amazonaws.com/v1/repos/deployment
  492  git push -u origin dev
  493  touch create-customer-microservice-tg-two.json
  494  aws ecs create-service --service-name customer-microservice --cli-input-json file://create-customer-microservice-tg-two.json
  495  create-employee-microservice-tg-two.json
  496  touch create-employee-microservice-tg-two.json
  497  aws ecs create-service --service-name employee-microservice --cli-input-json file://create-employee-microservice-tg-two.json
  498  docker rm -f employee_1 
  499  cd ~/environment/microservices/employee
  500  docker build --tag employee .
  501  dbEndpoint=$(cat ~/environment/microservices/employee/app/config/config.js | grep 'APP_DB_HOST' | cut -d '"' -f2)
  502  echo $dbEndpoint 
  503  account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
  504  echo $account_id
  505  docker tag employee:latest $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest
  506  aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com
  507  docker push $account_id.dkr.ecr.us-east-1.amazonaws.com/employee:latest
  508  aws ecs update-service --cluster microservices-serverlesscluster --service customer-microservice --desired-count 3
  509  ls
  510  cd deployment/
  511  ls
  512  hisory
  513  history
  514  aws ecs update-service --cluster microservices-serverlesscluster --service customer-microservice --desired-count 0
  515  aws ecs update-service --cluster microservices-serverlesscluster --service employee-microservice --desired-count 0
  516  account_id=$(aws sts get-caller-identity |grep Account|cut -d '"' -f4)
  517  aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com
  518  LS
  519  ls
  520  cd deployment/
  521  ls
  522  cat appspec-customer.yaml 
  523  cat taskdef-customer.json 
  524  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  525  ls
  526  aws ecs register-task-definition --cli-input-json taskdef-customer.json
  527  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  528  vim taskdef-customer.json 
  529  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-customer.json"
  530  aws ecs register-task-definition --cli-input-json "file:///home/ec2-user/environment/deployment/taskdef-employee.json"
  531  ls
  532  cd deployment/
  533  history
  534  git add .
  535  git commit -m "deploymentImage_ID"
  536  git push origin dev
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




 
