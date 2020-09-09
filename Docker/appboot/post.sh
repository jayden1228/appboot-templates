#!/bin/bash
shell_dir=$(dirname $0)
cd ${shell_dir}

# Git
cd ..
GIT_URL=git@{{.GitHost}}:{{.GitGroup}}/{{.Name}}.git
git init
git remote add origin ${GIT_URL}
git add .
git reset appboot
git commit -m "Initial commit"
git push -u origin master
cd ${shell_dir}