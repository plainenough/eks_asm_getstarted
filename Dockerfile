FROM ubuntu:bionic

ENV region=us-east-1

ARG DEBIAN_FRONTEND=noninteractive

#  Setting some labels that describe my container
LABEL     org.label-schema.name="asm-demo" \
          org.label-schema.description="Simple container to grep secrets from AWS Secretsmanager." \
          org.label-schema.url="https://github.com/plainenough/eks_asm_demo.git" \
          org.label-schema.vendor="tosstalk.com" \
          org.label-schema.version="1.0.0"

#  Changing to the root user
USER root

#  Running updates and installing apache
RUN apt-get update && apt-get install -y awscli jq curl

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

RUN chmod +x ./kubectl

RUN mv ./kubectl /usr/local/bin/

COPY entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/entrypoint.sh

ENTRYPOINT /root/entrypoint.sh
