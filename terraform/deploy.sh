#!/bin/bash

set -e

REPO_URL="https://github.com/akshayagrawal2805/Terraform-AWS-Ansible-Application-deploy-Project.git"

echo "===== Starting Deployment ====="

git clone -b master $REPO_URL
cd Terraform-AWS-Ansible-Application-deploy-Project

# Checking and rectifying permission issue
sudo chown -R ubuntu:ubuntu ~/Terraform-AWS-Ansible-Application-deploy-Project

echo "Installing dependencies..."
npm install

echo "Starting application..."
nohup npm start > app.log 2>&1 &

echo "===== Deployment Completed ====="
