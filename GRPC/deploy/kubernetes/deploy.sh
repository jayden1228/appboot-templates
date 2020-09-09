#!/bin/bash
shell_dir=$(dirname $0)
cd ${shell_dir}

# check params
if [[ ! $1 ]]; then
    echo "kubectl config is null"; exit 1;
else
    echo "kubectl config：$1"
fi

if [[ ! $2 ]]; then
    echo "app environment is null"; exit 1;
else
    echo "app environment：$2"
fi

kubectl config use $1
kustomize build overlays/$2 | kubectl apply -f -