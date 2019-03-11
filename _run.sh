#!/bin/zsh
# docker rm -f ruby_cnt
docker run -d -p 8080:3000 -v ~/Desktop/Projects:/home/docker/data:z -t --name=ruby_cnt ruby_img:rdev
docker exec -it -u=docker ruby_cnt zsh