# eks_asm_getstarted
Just a simple repo to POC EKS/ASM integration

## Required tools
* kubectl
* awscli
* eksctl

## Setup
Replace anything with `<value>` with the required value.
Setup aws credentials.

## Create docker container
Use the following commands to create the docker container from the repo root directory.
```
docker build -t your-tag .
docker push your-tag
```

## Generate EKS cluster
Use the following commands to create the EKS Cluster from the repo root directory.
```
eksctl create cluster -f cluster.yaml
```

## Create a secrets in ASM
Use the following commands to create the ASM secrets.
```
aws secretsmanager create-secret --region region --name secretname --description "The first example secret that is needed" --secret-string "mysecret"
```

## Deploy into EKS
Use the following commands to create the k8s deployment from the repo root directory.
```
kubectl -n secrets apply -f deployment.yaml 
kubectl -n secrets logs readsecrets
kubectl -n secrets delete -f deployment.yaml
```

# TODO:
* Provide more links
