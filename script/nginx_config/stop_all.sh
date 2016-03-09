#!/bin/bash

cmd="sudo /srv/nginx/sbin/nginx -s stop"

ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd
