pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                git credentialsId: 'gitnew', url: 'https://github.com/aatmaani/devops.git'
            }
        }
        stage('Build docker image') {
            steps {
                sh 'sudo docker build -t project/nodejs-app:$BUILD_NUMBER .'
            }
        }
        stage('push image to ECR') {
            steps {
                sh 'bash Dockerpushtoecr.sh'
            }
        }
        stage('Helm chart deploy') {
            steps {
                sh 'helm upgrade nodejs-dev nodejs -f values-dev.yaml -n dev'
            }
        }
    }
}


