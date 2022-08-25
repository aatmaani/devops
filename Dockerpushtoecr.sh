#/bin/bash
sudo -i
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 215767047920.dkr.ecr.ap-south-1.amazonaws.com
#sudo  docker tag 123 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1 
#sudo  docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1 

docker tag project/nodejs-app:$BUILD_NUMBER 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1

docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1

