#!/bin/bash
#cmd="cd /srv/rorapps/huafei2/ && git pull&& touch /srv/rorapps/huafei2/tmp/restart.txt && git log -1"
cmd="cd /srv/rorapps/huafei2/ && git pull"
#cmd="cd /srv/rorapps/huafei2/ && git pull && /srv/rorapps/huafei2/service_thin.sh hup"
#cmd="cd /srv/rorapps/huafei2/ && git pull"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_change_retry.sh restart 2 && sudo ./god_charge.sh restart 2 && sudo ./god_first_charging.sh restart 2 &&  sudo ./god_change_retry_sql.sh restart && sudo ./god_charge_sql.sh restart && sudo ./god_callback.sh restart 2  && rm -rf ./tmp/话*.pid"

#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_change_retry.sh restart  && sudo ./god_change_retry_sql.sh restart && rm -rf ./tmp/话*.pid"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_change_retry.sh restart 2 &&  rm -rf ./tmp/话费充值重试SQSTry*.pid"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_change_retry_sql.sh restart  && rm -rf ./tmp/话费充值重试SQLTryChangeRetrySQL*.pid"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_first_charging.sh restart 2 && rm -rf ./tmp/话费首次充值*.pid"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_charge.sh restart 2 && rm -rf ./tmp/话费充值同步*.pid"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_charge_sql.sh restart  && rm -rf ./tmp/话*.pid"
cmd="cd /srv/rorapps/huafei2/ && sudo ./god_callback.sh restart 2 && rm -rf ./tmp/话费回调*.pid"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_pay_code.sh stop"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./god_callback.sh stop 2"
#cmd="cd /srv/rorapps/huafei2/ && sudo ./rc_local.sh"

#cmd="cd /srv/rorapps/huafei2/ && rm -rf ./log/god.production.log"

#cmd="cd /srv/rorapps/huafei2/ && rm -rf ./log/god.production.log"


ssh h10 $cmd
sleep 10

ssh h11 $cmd
sleep 10

ssh h12 $cmd
sleep 10

ssh h13 $cmd
sleep 10

ssh h14 $cmd
sleep 10

ssh h15 $cmd
sleep 10

ssh h16 $cmd
sleep 10

ssh h17 $cmd

