#/bin/bash
#sudo -i
#mkdir Dev-v1

cd Dev-v1
git clone https://github.com/aatmaani/project.git

cd project
docker build -t project/nodejs-app:Dev-v1 .

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 215767047920.dkr.ecr.ap-south-1.amazonaws.com
#sudo  docker tag 123 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1 
#sudo  docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1 

docker tag project/nodejs-app:Dev-v1 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:Dev-v1

docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:Dev-v1
cd
cd workspace/123/charts

helm upgrade --install nodejs-dev nodejs -f values-dev.yaml --set image.tag=Dev-v1 -n dev

