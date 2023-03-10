#!/bin/zsh
terraform init

sleep 5

terraform plan -var-file="terraform.tfvars"

sleep 10

terraform apply -var-file="terraform.tfvars" -auto-approve

sleep 120

export KUBE_VAR=`terraform output kubeconfig` && echo $KUBE_VAR | base64 -di > ~/.secrets/.lke-cluster-config.yaml && chmod 0600 ~/.secrets/.lke-cluster-config.yaml

kubectl get po --all-namespaces

echo "Done!"