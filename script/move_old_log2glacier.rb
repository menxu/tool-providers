#!/usr/bin/env ruby
# encoding: UTF-8

# 转移 nginx 和 huafei2 的日志到 s3 glacier 中
# 当前月的日志不转移

require 'date'

# 计算出每一天,跳过当前月之后的日期
day_of_year = (Date.parse("#{Time.now.year}-10-01")..Date.parse("#{Time.now.year}-12-31")).to_a.map{|d| 
  next if d.strftime("%Y%m") >= Time.now.strftime("%Y%m")
  d.strftime("%Y%m%d")
}.delete_if{|x| x == nil}




# 需要转移的主机
hosts = 10.upto(17).map{|i| "ip-10-0-1-#{i}"}

# 需要转移的文件
# s3://logger/ec2/<host>/nginx/logs/access_<日期>.log 到 s3://logger/ec2/<host>/nginx/logs/Glacier-<年月>/access_<日期>.log
# s3://logger/ec2/<host>/nginx/logs/error_<日期>.log 到 s3://logger/ec2/<host>/nginx/logs/Glacier-<年月>/error_<日期>.log
# s3://logger/ec2/<host>/rorapps/huafei2/log/production_日期.log 到 s3://logger/ec2/<host>/rorapps/huafei2/log/Glacier-<年月>/production_日期.log

cmds = []
hosts.each do |host|
  day_of_year.each do |day|
    y = day[0,6]
    cmds << %Q~aws s3 mv s3://logger/ec2/#{host}/nginx/logs/access_#{day}.log s3://logger/ec2/#{host}/nginx/logs/Glacier-#{y}/access_#{day}.log~
    cmds << %Q~aws s3 mv s3://logger/ec2/#{host}/nginx/logs/error_#{day}.log s3://logger/ec2/#{host}/nginx/logs/Glacier-#{y}/error_#{day}.log~
    cmds << %Q~aws s3 mv s3://logger/ec2/#{host}/rorapps/huafei2/log/production_#{day}.log s3://logger/ec2/#{host}/rorapps/huafei2/log/Glacier-#{y}/production_#{day}.log~
  end
end

puts cmds
cmds.each do |cmd|
  #puts cmd
  puts `#{cmd}`
end

