#!/bin/bash

echo "Starting script"

for secret in `echo $secretslist | jq -c '.[]'`; do 
    echo "secret: $secret" &&
    export `echo $secret|cut -d\" -f2`=$(aws secretsmanager --region $region get-secret-value --secret-id `echo $secret |
    cut -d\" -f2` | jq ."SecretString" | cut -d\" -f2) && \
    echo "secret retrieval succeeded" || echo "secret retrieval failed"
done

echo 'printed environment variables'
echo '-------------'
echo '-------------'
echo '-------------'
env
echo '-------------'
echo '-------------'
echo '-------------'
echo "Done with environmental Secrets"

##############################################################
### This section will need you to supply some credentials ####
#echo "import secrets into k8s"
#for secret in `echo $secretslist | jq -c '.[]'`; do
#    echo "secret: $secret" && \
#    aws secretsmanager --region $region get-secret-value --secret-id `echo $secret | cut -d\" -f2` | jq ."SecretString" | cut -d\" -f2 > ./secret && \
#    echo "kubectl create secret generic $(echo $secret|cut -d\" -f2) --from-file=$(echo $secret|cut -d\" -f2)=./secret -n secret" | bash
#done
#echo "done writing secrets"
#echo '-------------'
#echo '-------------'
#echo '-------------'

#echo "pull secrets from eks secret store"
#for secret in `echo $secretslist | jq -c '.[]'`; do
#    echo "secret: $secret" && \
#    echo "kubectl get secret  $(echo $secret|cut -d\" -f2) -n secret" | bash
#done
###############################################################
