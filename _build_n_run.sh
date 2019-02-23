#!/bin/zsh
docker rmi -f ruby_img:rdev
docker build --rm -t ruby_img:rdev .
docker run -d -p 8080:3000 -v  ~/Desktop:/home/docker/data:z -t --cpus=4 --memory=4g --name=ruby_cnt  ruby_img:rdev
docker exec -it -u=docker ruby_cnt zsh