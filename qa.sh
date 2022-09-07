aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 215767047920.dkr.ecr.ap-south-1.amazonaws.com

docker pull 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:QA-v1
docker tag 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestDev 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestQA

docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestQA

aws ecr describe-images --repository-name project/nodejs-app

cd
cd workspace/QA/charts/

helm  upgrade --install nodejs-qa nodejs -f values-qa.yaml --set image.tag=latestQA -n qa
