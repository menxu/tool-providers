
source 'https://ruby.taobao.org'
# if ENV['RUBYTAOBAO']
# 	puts "user taobao source"
# 	source 'https://ruby.taobao.org'
# else
# 	source 'https://rubygems.org'
# end

gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem "compass-rails", github: "Compass/compass-rails", branch: "master"
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails'
gem 'simple_form'
gem 'slim-rails'
gem "foundation-rails", "5.5.3.2"
gem 'foundation-icons-sass-rails'
gem "font-awesome-rails"
gem 'underscore-rails'
gem 'angularjs-rails'
#graping
gem "chartkick"
# gem "groupdate"
gem "dateslices"
#like will_paginate
gem 'kaminari', github: 'amatsuda/kaminari'
gem 'jbuilder', '~> 2.0'

gem 'cancancan', '~> 1.7'
gem 'devise'
gem 'devise-async'
gem 'devise_invitable'
#user Role
gem 'rolify'

#settting Unix shell
gem 'figaro'
gem 'settingslogic'

# markdown 解析器
gem 'redcarpet'
# 代码高亮
gem 'coderay'

#search
gem 'progress_bar'
gem 'sunspot_rails'
gem 'sunspot_solr'

#background cron
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil

# for observers
gem 'rails-observers'

gem 'state_machine'

# for sns login
gem 'omniauth-weibo-oauth2'
gem 'weibo2'
gem 'oauth'
gem 'oauth_china'

# for upload picture
gem 'mini_magick'
gem 'carrierwave'

# i18n
gem 'rails-i18n', '~> 4.0.0'
gem 'i18n-tasks', '~> 0.8.3'
gem 'angular-translate-rails'


# web server
gem 'unicorn'
gem 'passenger'

# deploy
gem 'mina', require: false
gem 'mina-sidekiq', require: false

# Log Analysis
# https://ruby-china.org/topics/2990 使用 Spork + Guard + RSpec + Capybara
# https://ruby-china.org/topics/14039 delay server
# http://www.oschina.net/project/tag/147/log-analyzer?lang=0&os=0&sort=view&p=4 共有95款 日志分析和统计开源软件
gem 'request-log-analyzer'

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem "spring-commands-rspec"
  gem 'thin'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '2.14.2'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'sqlite3'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-sidekiq'
end

