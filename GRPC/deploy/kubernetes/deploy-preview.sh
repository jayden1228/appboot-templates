#!/bin/bash
shell_dir=$(dirname $0)
cd ${shell_dir}

# check params
if [[ ! $1 ]]; then
    echo "image tag is null"; exit 1;
else
    echo "image tag：$1"
fi

if [[ ! $2 ]]; then
    echo "git.commit.id is null"; exit 1;
else
    echo "git.commit.id：$2"
fi

if [[ ! $3 ]]; then
    echo "app environment is null"; exit 1;
else
    echo "app environment：$3"
fi

cd base
kustomize edit set image $1
kustomize edit add annotation git.commit.id:$2
kustomize build ../overlays/$3