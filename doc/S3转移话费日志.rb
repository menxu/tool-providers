#!/usr/bin/env ruby
# encoding: UTF-8
# 按月将指定目录下的文件转移到 Glacier-<年月> 目录下
require 'aws-sdk-v1'

hosts = 10.upto(17).map{|i| "ip-10-0-1-#{i}"}
hosts = %w(fgpay2
ip-10-0-0-127
ip-10-0-0-229
ip-10-0-1-10
ip-10-0-1-11
ip-10-0-1-12
ip-10-0-1-13
ip-10-0-1-14
ip-10-0-1-15
ip-10-0-1-16
ip-10-0-1-17
ip-10-0-1-8
ip-10-0-1-9
ip-10-150-150-67
ip-172-31-7-77)

huafei_log_prefixs = hosts.map{|h| "ec2/#{h}/rorapps/huafei2/log/production_"}

nginx_access_log_prefixs = hosts.map{|h| "ec2/#{h}/nginx/logs/access_"}
nginx_error_log_prefixs = hosts.map{|h| "ec2/#{h}/nginx/logs/error_"}

def move2glacier(prefixs)
  s3_logger = AWS::S3.new.buckets['logger']
  curr_month = Time.now.strftime("%Y%m")
  prefixs.each do |pf|
    sux = File.basename(pf)
    s3_logger.objects.with_prefix(pf).each do |obj|
      next unless obj.exists?
      key = obj.key.to_s
      next if key.include?(curr_month)
      if key =~ /#{sux}(\d{6})/
        new_key = "#{key.gsub("#{sux}","Glacier-#{$1}/#{sux}")}"
        puts "move #{key} to #{new_key}"
        obj.move_to(new_key)
      end
    end
  end
end


move2glacier(huafei_log_prefixs)
move2glacier(nginx_access_log_prefixs)
move2glacier(nginx_error_log_prefixs)
