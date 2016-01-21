#!/bin/bash

#ssh $1 "tail -f /srv/rorapps/huafei2/log/production.log"

day=$1
month=$2

echo $day

aws s3 cp s3://logger/ec2/ip-10-0-1-10/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-10_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-11/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-11_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-12/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-12_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-13/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-13_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-14/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-14_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-15/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-15_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-16/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-16_production_$day

aws s3 cp s3://logger/ec2/ip-10-0-1-17/rorapps/huafei2/log/production_$day /mnt/logger/ip-10-0-1-17_production_$day


#aws s3 cp s3://logger/ec2/ip-10-0-1-10/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-10_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-11/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-11_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-12/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-12_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-13/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-13_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-14/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-14_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-15/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-15_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-16/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-16_production_$day.log
#aws s3 cp s3://logger/ec2/ip-10-0-1-17/rorapps/huafei2/log/Glacier-$month/production_$day.log ./ip-10-0-1-17_production_$day.log
