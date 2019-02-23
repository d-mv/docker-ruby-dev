#!/bin/zsh
# docker rm -f ruby_cnt
docker run -d -p 8080:4567 -v  ~/Desktop/LeWagon:/home/docker/data:z -t --name=ruby_cnt ruby_img:rdev
docker exec -it -u=docker ruby_cnt zsh