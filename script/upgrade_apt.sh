#!/bin/bash


#cmd="sudo apt-get update && sudo apt-get upgrade -y"
cmd="grep security /etc/apt/sources.list > /tmp/security.list && sudo apt-get upgrade -oDir::Etc::Sourcelist=/tmp/security.list -y"

ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd
