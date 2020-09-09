#!/bin/bash
shell_dir=$(dirname $0)
cd ${shell_dir}

# open with vscode
if which code >/dev/null; then
  code ..
else
  echo "warning: 'code' command has not installed in PATH"
fi

# Gitlab
if which gitlab >/dev/null; then
  gitlab createProject -n "{{.Name}}" -g "{{.GitGroup}}" -d "{{.GitDescription}}" -l "{{.GitTopics}}" -u "https://jenkins.makeblock.com/multibranch-webhook-trigger/invoke?token={{.JenkinsFolder}}-{{.Name}}"
else
  echo "warning: 'gitlab' command has not installed in PATH"
fi

# Push Code
cd ..
GIT_URL=git@{{.GitHost}}:{{.GitGroup}}/{{.Name}}.git
git init
git remote add origin ${GIT_URL}
git add .
git reset appboot
git commit -m "Initial commit"
git push -u origin master
cd ${shell_dir}

# create jenkins job
if which jenkinsapi >/dev/null; then
  JENKINS_CONFIG=$(cat ./jenkins.xml)
  JENKINS_JOB_TOKEN={{.JenkinsFolder}}-{{.Name}}
  JENKINS_CONFIG=${JENKINS_CONFIG/APPBOOT_TOKEN/${JENKINS_JOB_TOKEN}}
  JENKINS_CONFIG=${JENKINS_CONFIG/APPBOOT_GIT_URL/${GIT_URL}}
  jenkinsapi create -j "{{.Name}}" -f "{{.JenkinsFolder}}" -c "${JENKINS_CONFIG}"
else
  echo "warning: 'jenkinsapi' command has not installed in PATH"
fi