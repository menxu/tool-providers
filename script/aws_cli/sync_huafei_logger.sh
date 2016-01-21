#!/bin/bash

export AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_REGION=cn-north-1

mkdir -p /mnt/tmp/srv/nginx/logs
mkdir -p /mnt/tmp/srv/rorapps/huafei2/log

#run-at www user
# username logger
aws s3 sync /srv/rorapps/huafei2/log/ s3://logger/ec2/${HOSTNAME}/rorapps/huafei2/log --exclude production.log --exclude 9000.log --exclude shoujichongzhi.log --exclude "god*"  --exclude memory_profiler.log  --exclude "thin*"  --exclude "tmp*.log" --exclude "timing.log"
aws s3 sync /srv/nginx/logs/ s3://logger/ec2/${HOSTNAME}/nginx/logs --exclude error.log --exclude "*.pid" --exclude access.log

mv /srv/rorapps/huafei2/log/*_20*.log /mnt/tmp/srv/rorapps/huafei2/log 
mv /srv/nginx/logs/*_20*.log /mnt/tmp/srv/nginx/logs 

