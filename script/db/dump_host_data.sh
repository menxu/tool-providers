#!/bin/bash

tbs=("order_records_2010_1" "order_records_2010_2" "order_records_2011_1" "order_records_2011_2" "order_records_2012_1" "order_records_2012_2" "order_records_2013_1" "order_records_2013_2" "order_records_2014_1" "order_records_2014_2" "order_records")

for t in "${tbs[@]}"
do
    cmd="copy(select mobile_num,to_char(created_at,'yyyy-MM-DD HH:mm:ss'),province,'huafei',amount,pay_status from ${t} limit 1) TO STDOUT CSV;"
    $cmd
done