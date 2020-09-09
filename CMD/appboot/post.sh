#!/bin/bash
shell_dir=$(dirname $0)
cd ${shell_dir}

# open with vscode
if which code >/dev/null; then
  code ..
else
  echo "warning: 'code' command has not installed in PATH"
fi

# Git
cd ..
GIT_URL=git@{{.GitHost}}:{{.GitGroup}}/{{.Name}}.git
git init
git remote add origin ${GIT_URL}
git add .
git reset appboot
git commit -m "Initial commit"
git push -u origin master