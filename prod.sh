aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 215767047920.dkr.ecr.ap-south-1.amazonaws.com

docker pull 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:qalatest

docker tag 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:prodlatest

docker push 215767047920.dkr.ecr.ap-south-1.amazonaws.com/project/nodejs-app:prodlatest

aws ecr describe-images --repository-name project/nodejs-app

