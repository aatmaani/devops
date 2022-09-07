aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 215767047920.dkr.ecr.ap-south-1.amazonaws.com

docker pull 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestQA

docker tag 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:latestQA 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:prod-v1

docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:prod-v1

aws ecr describe-images --repository-name project/nodejs-app

cd
cd workspace/Prod/charts/

helm upgrade --install nodejs-prod nodejs -f values-prod.yaml --set image.tag=prod-v1 -n prod

