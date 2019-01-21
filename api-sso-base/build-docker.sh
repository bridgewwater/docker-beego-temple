#!/bin/bash

shell_run_path=$(cd `dirname $0`; pwd)

beego_repo_uri="git@github.com:astaxie/beego.git"
target_mark="v1.9.2"

repo_download_path="${shell_run_path}/src/github.com/astaxie/beego"
if [[ -d ${repo_download_path} ]]; then
    echo "-> find old version for beego in build, just remove"
    rm -rf ${repo_download_path}
fi

git clone ${beego_repo_uri} -b ${target_mark} ${repo_download_path}
rm -rf ${repo_download_path}/.git

docker_image_name="api/oss/base"
docker_tag="1.0.0"

if [ -n "${docker_tag}" ];then
    docker build -t ${docker_image_name}:${docker_tag} .
    echo -e "just make local image ${docker_image_name}:${docker_tag}"
else
    docker build -t ${docker_image_name} .
    echo -e "just make local image ${docker_image_name}"
fi
