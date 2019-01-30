#!/bin/zsh
docker build --rm -t ruby-dev_image .
docker run -d -t -v $PWD/data:/home/docker/data:z -t --cpus=4 --memory=4g --name=ruby-dev_cont ruby-dev_image
docker exec -it -u=docker ruby-dev_cont zsh