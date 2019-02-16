#!/bin/zsh
docker rm -f ruby-dev_cont
docker run -d -p 8080:3000 -v  ~/Desktop/Projects:/home/docker/data:z -t --name=ruby-dev_cont ruby-dev_image
docker exec -it -u=docker ruby-dev_cont zsh