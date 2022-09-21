# Devops
## _Aatmaani Devops Project_

[![Nodejs Project](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
[![Test Coverage](https://coveralls.io/repos/lovell/sharp/badge.svg?branch=main)](https://coveralls.io/r/lovell/sharp?branch=main)
[![Node-API v5](https://img.shields.io/badge/Node--API-v5-green.svg)](https://nodejs.org/dist/latest/docs/api/n-api.html#n_api_n_api_version_matrix)
[![npm version](https://badge.fury.io/js/pngjs.svg)](http://badge.fury.io/js/pngjs)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square) [![CI](https://github.com/upgundecha/howtheysre/actions/workflows/workflow.yml/badge.svg)](https://github.com/upgundecha/howtheysre/actions/workflows/workflow.yml)

## Devops
  DevOps is a set of practices that combines software development (Dev) and IT operations (Ops). It aims to shorten the systems development life cycle and provide continuous delivery with high software quality DevOps is complementary with Agile software development; several DevOps aspects came from the Agile way of working.

- Continuous development
- Continuous integration
- Continuous testing
- Continuous Delivery or continuous deployment
- Continuous Monitoring
- Continuous feedback
- Continuous operations

![](https://raw.githubusercontent.com/maheshkn400/DevOps/master/img/devops-toolchain.png)
## Aatmaani Project 
 Nodejs Project we used in this Project for CI/CD Pipeline 
## Tools
**Git**
  
  Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

**GitHub**

  Github  is an Internet hosting service for software development and version control using Git. It provides the distributed version control of Git plus access control, bug tracking, software feature requests, task management, continuous integration, and wikis for every project.

**AWS**

AWS is provides on-demand cloud computing platforms and APIs to individuals, companies, and governments, on a metered pay-as-you-go basis.

**Jenkins**

Jenkins is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.

**Docker**

Docker is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called containers.The software that hosts the containers is called Docker Engine.

**Kubernetes**

Its is a container orchestration system for automating software deployment, scaling, and management, Kubernetes works with Docker.

**Helm**

Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

**Efk**

EFK stands for Elasticsearch, Fluentd, and Kibana. EFK is a popular and the best open-source choice for the Kubernetes log aggregation and analysis. Elasticsearch is a distributed and scalable search engine commonly used to sift through large volumes of log data.Fluentd is a log shipper. It is an open source log collection,Kibana is UI tool for querying, data visualization and dashboards.

**Prometheus & Grafana**

Prometheus is an open source monitoring system for which Grafana provides out-of-the-box support.Grafana to display system metrics for a server monitored by Prometheus.Prometheus node_exporter is a widely used tool that exposes system metrics & hosts you want to monitor.

## _Project interpretation_

![alt text](https://raw.githubusercontent.com/aatmaani/devops/main/Aws%20project.png)
# Phase 1 [Repo]
![alt text](https://raw.githubusercontent.com/aatmaani/123/main/Untitled%20Diagram.drawio.png)


**Git**
  
  Developer clone the Aaatmaani Project from http://github.com/aatmaani/project/ This is a Nodejs application. Pipeline work on the http://github/aatmaani/devops/ repo
  
**GitHub**
   
   Create a 2 Branches 
   - Main Branch
   - Dev Branch

**Main Branch**
Main Branch is Restricte the branch , main branch is accepte by only Pull Request, Developer not commite directly to the main branch, only admin can access the Main Branch. Once Main branch is merge happen automatically trigger to the Jenkins pipeline Through the Webhook Methodology.
 
 **Dev Branch**
  Developer push only Dev Branch.
  
# Phase2 [Infrastructure setup]
  ![](https://raw.githubusercontent.com/aatmaani/123/main/2%20Untitled%20Diagram.drawio.png)
  
  **Pre-Request**
  - Install Jenkins
  - Install Terraform
  - Install Docker
  - Install Kubectl (Dependent Version)
  - Create EKS cluster through terraform & connect to the Cluster
  - Install Helm3
          - Create 3 Namespace
             - 1. Dev
             - 2. QA
             - 3. Prod

# Phase3 [CI/CD]

**Created 3 Environment Pipeline**

**1.Dev**

**2 QA**

**3.Prod**

# DEV-Environment 

![](https://raw.githubusercontent.com/aatmaani/123/main/3Untitled%20Diagram.drawio.png)

Entier Pipeline is run in Declarative Pipeline in Jenkins.

**Docker images**
 Clone the Nodejs project from https://github.com/aatmaani/project.git here
and there have a Dockerfile to compose the Docker images.

```sh
git clone https://github.com/aatmaani/project.git
cd project
docker build -t project/nodejs-app:latestDev .
```
Now Docker image was build with the specific tag.

**ECR**

After Docker build Push to the AWS ECR repo with the Dev latest image.

**Helm**

Created custom Helm chart for the Deploy it in Kubernetes cluster using the Dev Namespace, Created  Dev Values yml file it have 1 replicas, svc Loadbalancer etc.. Customize Helm chart is store in Github Pipeline .

```sh
helm upgrade --install realese name chart -f valuefile --set image.tag=latestDev -n dev
``` 

# QA-Environment 

![](https://raw.githubusercontent.com/aatmaani/123/main/4%20Untitled%20Diagram.drawio.png)

**ECR**
 
  Pull the Docker Dev latest image from AWS ECR to locally or QA testing team

**QA**
 
 Pull the dev latest images test it locally & intgerate dependencies. After test it Push to the QA latest image in AWS ECR.
 
 **Helm**
 
 Created custom Helm chart for the Deploy it in Kubernetes cluster using the QA Namespace, Created  QA Values yml file it have 1 replicas, svc Loadbalancer etc.. Customize Helm chart is store in Github Pipeline.
 
 ```sh
 helm  upgrade --install nodejs-qa nodejs -f values-qa.yaml --set image.tag=latestQA -n qa
```
# Prod-Environment 

![](https://raw.githubusercontent.com/aatmaani/123/main/5%20Untitled%20Diagram.drawio.png)


 
**ECR**

Pull the QA latest image to the local & push to the the AWS ECR in Prod latest.

**Helm**

Same Helm chart Template use in the Prod Env Deploy it kubernetes cluster using Prod Namespace, Created prod values yml files which is enable HPA,Cluster Autoscaler, 2 Replicas. Deploy Monitoring tools in Prod env.

```sh
 helm  upgrade --install nodejs-prod nodejs -f values-prod.yaml --set image.tag=latestprod -n Prod
```

**Slack Notification**

When Jenkins Pipeline is Fail send the Notification to the Slack Channel.

# Phase4 [Continuous Monitoring]



