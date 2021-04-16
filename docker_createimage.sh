# This script is used to create docker images

#! /bin/bash

echo "creating webserver image"
sudo docker build -t evote_web:latest ./webserver

echo "creating dbserver image"
sudo docker build -t evote_db:latest ./dbserver

echo "creating bc image"
sudo docker build -t evote_bc:latest ./bc

echo "creating orderer image"
sudo docker build -t evote_orderer:latest ./orderer

echo "creating load_balancer image"
sudo docker build -t evote_lb:latest ./load_balancer

echo "creating timer image"
sudo docker build -t evote_timer:latest ./timer

echo "Done!"
