#!/bin/bash

docker_image_name="sinlov/bee"
docker_tag="1.9.1"

if [ -n "${docker_tag}" ];then
    docker build -t ${docker_image_name}:${docker_tag} .
    echo -e "just make local image ${docker_image_name}:${docker_tag}"
else
    docker build -t ${docker_image_name} .
    echo -e "just make local image ${docker_image_name}"
fi
