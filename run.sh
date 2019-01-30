#!/bin/zsh
docker rm ruby-dev_cont
docker run -d -v $PWD/data:/home/docker/data:z -t --name=ruby-dev_cont ruby-dev_image
docker exec -it -u=docker ruby-dev_cont zsh