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
 This is an Express Nodejs Project for CI/CD Pipeline. (Express Nodejs- Express is a node js web application framework that provides broad features for building web and mobile applications. It is used to build a single page, multipage, and hybrid web application. It's a layer built on the top of the Node js that helps manage servers and routes).
 
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

Helm helps you manage Kubernetes applications ??? Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

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
          - Create 3 Namespace inside the cluster
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

Entier Pipeline is run in *Declarative Pipeline* in Jenkins.

**Docker images**
 Clone the Nodejs project from https://github.com/aatmaani/project.git here
and there have a Dockerfile & build the Docker images.

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
Service - LoadBalancer.

```sh
helm upgrade --install realese name chart -f valuefile --set image.tag=latestDev -n dev
``` 
After check the SVC it shows external ip copy the URL & past it in Browser web page is running.

# QA-Environment 

![](https://raw.githubusercontent.com/aatmaani/123/main/4%20Untitled%20Diagram.drawio.png)

**ECR**
 
  Pull the Docker Dev latest image from AWS ECR to locally or QA testing team

**QA**
 
 Pull the dev latest images test it locally & intgerate dependencies. After test it Push to the QA latest image in AWS ECR.
 
 **Helm**
 
 Created custom Helm chart for the Deploy it in Kubernetes cluster using the QA Namespace, Created  QA Values yml file it have 1 replicas, svc Loadbalancer etc.. Customize Helm chart is store in Github Pipeline.
 Service - LoadBalancer
 
 ```sh
 helm  upgrade --install nodejs-qa nodejs -f values-qa.yaml --set image.tag=latestQA -n qa
```
After check the SVC it shows external ip copy the URL & past it in Browser web page is running.

# Prod-Environment 

![](https://raw.githubusercontent.com/aatmaani/123/main/5%20Untitled%20Diagram.drawio.png)


 
**ECR**

Pull the QA latest image to the local & push to the the AWS ECR in Prod latest.

**Helm**

Same Helm chart Template use in the Prod Env Deploy it kubernetes cluster using Prod Namespace, Created prod values yml files which is enable HPA,Cluster Autoscaler, 2 Replicas. Deploy Monitoring tools in Prod env.
Service - LoadBalancer

```sh
 helm  upgrade --install nodejs-prod nodejs -f values-prod.yaml --set image.tag=latestprod -n Prod
```
After check the SVC it shows external ip copy the URL & past it in Browser web page is running.

**Slack Notification**

When Jenkins Pipeline is Fail send the Notification to the Slack Jenkins-status Channel.

# Phase4 [Continuous Monitoring]

![](https://raw.githubusercontent.com/aatmaani/123/main/6%20Untitled%20Diagram.drawio.png)

**EFK**

Install EFK in Prod Environment using Helm charts below command is how to install & setup is shown.

*Elasticsearch*
```sh
kubectl create ns efk
helm repo add elastic https://helm.elastic.co
helm show values elastic/elasticsearch >> elasticsearch.values
vi elasticsearch.values
  - Update replicas & Masternode 1 , resource min 2G.
helm install elasticsearch elastic/elasticsearch -f elasticsearch.values -n efk
```
*kibana*
```sh
helm show values elastic/kibana >> kibana.values
vi kibana.values
  - Replace ClusterIP to LoadBalancer
helm install kibana elastic/kibana -f kibana.values -n efk
```
*Fluentd*
```sh
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
helm show values fluent/fluentd >> fluentd.values
vi fluentd.values
            - if u want enable Persistant volume
helm install fluentd fluent/fluentd -n efk
```

*Default Running ports*
Port 9200   - Elasticsearch 

Port 5601   - Kibana

port 9100   -  Node Exporter

After installing check svc take Kibana External ip & check it in browser http:xxxxxxxxxxxxxxx:5601 u get the Home pages & check it Prod logs.

**Prometheus & Grafana**

Prometheus collect the metric from Node exporter e.g each nodes,pods,conatiner etc.. utilization is check it.

*Install Prometheus and Grafana on Kubernetes using Helm 3*

```sh
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm search repo prometheus-community
helm install [RELEASE_NAME(stable)] prometheus-community/kube-prometheus-stack
kubectl edit svc stable-kube-prometheus-sta-prometheus
- Here we are changing from ClusterIP to LoadBalancer/NodePort
kubectl edit svc stable-grafana
- Change from ClusterIP to LoadBalancer/NodePort
```
*Default running port*

Port 9090?????????Prometheus Server

Port 9100?????????Prometheus Node Exporter

Port 3000?????????Grafana

*Access Prometheus and Grafana WEB Interface*
http://a9042a504d25f4122b6aa52ed5e53b57-356305290.ap-south-1.elb.amazonaws.com:9090

Kubernetes dashboard https://grafana.com/grafana/dashboards/7249-kubernetes-cluster/ using this port collecting metrics & visualizations.
- cluster health (pod status count, pod restarts etc.)
- cluster nodes (cpu, memory, storage etc.)
- running pods (cpu, memory etc.)

**Slack Notification**
 
Once the production Environment Metrics reach Threshold > 80 Alertmanager send the Notification to the Slack with the help of slack Webhook integeration to the config channels.




