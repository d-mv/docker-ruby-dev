#!/bin/zsh
docker rm ruby_cont
docker run -d -v $PWD/data:/home/docker/data:z -t --name=ruby_cont ruby_image
docker exec -it -u=docker ruby_cont zsh