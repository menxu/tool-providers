#!/bin/bash
cmd="sudo /srv/rorapps/huafei2/god_change_retry.sh stop"
ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd

cmd="sudo /srv/rorapps/huafei2/god_change_retry_sql.sh stop"
ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd

cmd="sudo /srv/rorapps/huafei2/god_charge.sh stop 2"
ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd

cmd="sudo /srv/rorapps/huafei2/god_charge_sql.sh stop"
ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd

cmd="sudo /srv/rorapps/huafei2/god_first_charging.sh stop"
ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd

cmd="sudo /srv/rorapps/huafei2/god_pay_code.sh stop"
ssh h10 $cmd
ssh h11 $cmd
ssh h12 $cmd
ssh h13 $cmd
ssh h14 $cmd
ssh h15 $cmd
ssh h16 $cmd
ssh h17 $cmd
