#!/bin/bash

echo 'h10......................'
ssh h10  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h11......................'
ssh h11  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h12......................'
ssh h12  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h13......................'
ssh h13  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h14......................'
ssh h14  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h15......................'
ssh h15  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h16......................'
ssh h16  "grep --color $1 /srv/rorapps/huafei2/log/production.log"

echo 'h17......................'
ssh h17  "grep --color $1 /srv/rorapps/huafei2/log/production.log"
