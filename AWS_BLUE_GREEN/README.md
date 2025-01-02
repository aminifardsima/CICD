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





 
