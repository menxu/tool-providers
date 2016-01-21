#!/bin/bash

cmd="sudo mv /tmp/nginx.conf /srv/nginx/conf/ && sudo /srv/nginx/sbin/nginx -s reload"

scp nginx.conf h10:/tmp/ && ssh h10 $cmd
scp nginx.conf h11:/tmp/ && ssh h11 $cmd
scp nginx.conf h12:/tmp/ && ssh h12 $cmd
scp nginx.conf h13:/tmp/ && ssh h13 $cmd
scp nginx.conf h14:/tmp/ && ssh h14 $cmd
scp nginx.conf h15:/tmp/ && ssh h15 $cmd
scp nginx.conf h16:/tmp/ && ssh h16 $cmd
scp nginx.conf h17:/tmp/ && ssh h17 $cmd
