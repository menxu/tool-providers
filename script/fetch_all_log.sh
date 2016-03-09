#!/bin/bash

# 用法:
# cd /tmp/
# ~/script/fetch_all_log.sh rorapps/huafei2/log/production_20140827.log production_20140827.log
aws s3 cp s3://logger/ec2/ip-10-0-1-10/$1 ip-10-0-1-10_$2
aws s3 cp s3://logger/ec2/ip-10-0-1-11/$1 ip-10-0-1-11_$2
aws s3 cp s3://logger/ec2/ip-10-0-1-12/$1 ip-10-0-1-12_$2
aws s3 cp s3://logger/ec2/ip-10-0-1-13/$1 ip-10-0-1-13_$2
aws s3 cp s3://logger/ec2/ip-10-0-1-13/$1 ip-10-0-1-14_$2
