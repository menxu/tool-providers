# config valid only for current version of Capistrano
# lock '3.4.0'

set :application, 'tool-providers'
set :repo_url, 'git@github.com:menxu/tool-providers.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# set :deploy_user, 'ubuntu'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/srv/rorapps/tool-providers'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/application.yml', 'config/database.yml', 'config/secrets.yml', 'config/secrets.yml', 'config/setting.yml', 'config/sidekiq.yml', 'config/sunspot.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

#whenever
# set :whenever_roles, :app 

namespace :deploy do

  # 自定义了一个部署任务, 即自动运行 rake RAILS_ENV=rails_env db:create
  # 其中 release_path 指的是当前 release 目录
  # `fetch(:rails_env)` 读取配置中的 rails_env 变量, 并在 rake 命令中带上 env 变量
  desc "create database"
  task :create_database do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
  # before :migrate, :create_database     # 在每次 rake db:migrate 前都运行 rake db:create
  # after  :finishing, 'deploy:cleanup'   # 在每次部署完毕后, 清理部署时生成的 tmp 文件及多余的版本

  task :uptime do
    on roles(:app), in: :parallel do |host|
      uptime = capture(:uptime)
      puts "#{host.hostname} reports: #{uptime}"
    end
  end

end
