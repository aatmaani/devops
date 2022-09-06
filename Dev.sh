#/bin/bash
#sudo -i
rm -rf *
mkdir latestDev

cd latestDev
git clone https://github.com/aatmaani/project.git

cd project
docker build -t project/nodejs-app:latestDev .

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 215767047920.dkr.ecr.ap-south-1.amazonaws.com
#sudo  docker tag 123 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1 
#sudo  docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:v1 

docker tag project/nodejs-app:latestDev 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestDev

docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestDev
cd
cd workspace/Dev/charts/
helm upgrade --install nodejs-dev nodejs -f values-dev.yaml --set image.tag=latestDev -n dev

