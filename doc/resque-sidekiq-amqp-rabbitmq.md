

### resque & sidekiq

#### resque 一个 worker 通过 fork 方式来产生多个 worker 处理多个任务

fork 一个进程，操作系统会建立一个独立分开的地址空间，并且从父进程复制所有的内存片段到这个地址里面去。 这就意味着对于操作系统来说，对于 fork 的进程切换上下文，因为需要保存和加载所有数据，所以代价更大。 而且如果父进程死掉了，这些 fork 的子进程没有退出的话，将会变成僵尸进程。

#### sidekiq 一个 worker 使用的 Thread 方式产生多个线程 处理多个任务。

thread 多线程的话是共享地址空间，内存并且多线程之间的交互也比较方便。而且你也不用担心僵尸进程的问题，一旦进程死掉， 所有的线程会自动被杀掉。但这种方式也有缺点，你必须保证代码是线程安全的,不然可能会引起麻烦

resque 比 sidekiq 更消耗内存

resque 的 worker 不需要考虑线程安全问题，sidekiq 必须考虑

###### resque 实现

1. 安装Redis

2. 安装redis-namespace

3. 安装Resque

  gem install redis redis-namespace resque、dalli

4. 配置resque信息

config/initializers/load_resque.rb

```ruby
require 'resque'
Resque.redis = 'localhost:6379'
Resque.redis.namespace = "webtails:resque"
Resque.redis.expire "key", 100 #设置数据在redis中的有效期
Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60) # 24hrs in seconds
```

5. 配置workers

```ruby
require "resque/tasks"

task "resque:setup" => :environment
```

6. 编写Task类

```ruby
class SendEmailTask
  @queue = "demo_task"

  def self.perform(target_email) 
    result = sendEmail(target_email) 
    Resque.redis[target_email] = result 
  end 
end
```

7. 启动

```ruby
VVERBOSE=1 COUNT=5 QUEUE=demo_task rake environment resque:workers

PIDFILE=./tmp/pids/demo_task.pid BACKGROUND=yes QUEUE=demo_task rake resque:work >>  /srv/rorapps/demo/log/demo_task.log &
```

8. web routes.rb

  mount Resque::Server, at: '/resque'

###### sidekiq 实现

1. 安装Redis

2. 安装redis-namespace

3. 安装Sidekiq

  gem install redis redis-namespace sidekiq

4. 配置sidekiq信息

config/secrets.yml
```ruby
redis: &redis
   redis_server: 'localhost'
   redis_port: 6379
   redis_db_num: 15
   redis_namespace: 'demo_sidekiq'
development:
  <<: *redis
```

config/initializers/load_sidekiq.rb
```ruby
redis_server = Rails.application.secrets.redis_server
redis_port = Rails.application.secrets.redis_port
redis_db_num = Rails.application.secrets.redis_db_num
redis_namespace = Rails.application.secrets.redis_namespace

Sidekiq.configure_server do |config|
  p redis_server
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
end
```

5. 启动配置文件 config/sidekiq.yml

bundle exec sidekiq --help
```ruby
---
:concurrency: 5
:pidfile: ./tmp/pids/sidekiq.pid
development:
  :concurrency: 5
test:
  :concurrency: 5
production:
  :concurrency: 5
:queues:
  - default
  - cloud_watch
  - healthy
  - sync_order
```

6. 配置workers

```ruby
class CloudWatchWorker
  include Sidekiq::Worker
  sidekiq_options queue: :cloud_watch, retry: false, backtrace: true
  def perform(name, options = {}) 
    #do something
  end 
end
```

7. 启动Sidekiq

bundle exec sidekiq -C config/sidekiq.yml

or use capistrano

RBENV_ROOT=~/.rbenv RBENV_VERSION=2.1.2 ~/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /srv/rorapps/demo/shared/tmp/pids/sidekiq.pid --environment production --logfile /srv/rorapps/demo/shared/log/sidekiq.log --queue sms, notification --concurrency 10 --daemon

8. 测试调用

CloudWatchWorker.perform_async 'SuccessOrder', {OrderRecord.last}

9. gem capistrano-sidekiq 

```ruby
bundle exec cap install
```
run `cap -vT`

set :sidekiq_config, "#{current_path}/config/sidekiq.yml"

关于capistrano http://www.rails365.net/articles/shi-yong-capistrano-bu-shu-rails-ying-yong

10. gem 'sinatra' 监控页面

require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'


### AMQP & RabbitMQ

#### AMQP 高级消息队列协议是一个异步消息传递所使用的应用层协议规范

#### RabbitMQ 是AMQP的一种基于erlang的实现

http://www.infoq.com/cn/articles/AMQP-RabbitMQ
http://codemacro.com/2013/04/11/rabbitmq-erlang/


