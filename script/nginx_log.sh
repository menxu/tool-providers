#!/bin/bash

ssh $1 "tail -f /srv/nginx/logs/access.log"
