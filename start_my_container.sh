#!/bin/bash

docker network create --driver bridge --subnet 192.168.0.0/24 my_custom_network || true

docker run -d --name my_container --network my_custom_network --ip 192.168.0.112 my-go-app:latest

