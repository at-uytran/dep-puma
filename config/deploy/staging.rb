set :branch, :master
set :deploy_to, '/var/www/dep-puma-app'
set :pty, true
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.5.3' 

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'staging'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

server "54.173.15.218", user: "uytv2", roles: %w{app}
# server "localhost", user: "chicken", roles: %w{db}

# namespace :custom do
#   task :ping_google do
#     on roles(:app) do
#       execute "ping google.com"
#     end
#   end

#   task :check_puma_state do
#     on roles(:app) do
#       execute "ps -aux | grep puma"
#     end
#   end

#   task :ask_your_name do
#     ask(:your_name, "guess")
#     on roles(:app) do
#       execute("echo \"$(whoami) Hello #{fetch(:your_name)}\"")
#     end
#   end
# end

# set :rails_env, "staging"

# namespace :deploy do
#   task :bundle_dependencies do
#     on roles(:app) do
#       within release_path do
#         execute "cd #{release_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle install --path /var/www/dep-puma-app/shared/bundle"
#       end
#     end
#   end

#   task :asset_precompile do
#     on roles(:app) do
#       within release_path do
#         execute "cd #{release_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec rake assets:precompile"
#       end
#     end
#   end

#   task :migrate_database do
#     on roles(:db) do
#       within release_path do
#         execute "cd #{release_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec rake db:migrate RAILS_ENV=#{fetch(:rails_env)}"
#       end
#     end
#   end

#   task :start_puma do
#     on roles(:app) do
#       within current_path do
#         execute "cd #{current_path} && (export RACK_ENV=#{fetch(:rails_env)} ; ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec puma -C config/puma.rb -d)"
#       end
#     end
#   end

#   task :stop_puma do
#     on roles(:app) do
#       within current_path do
#         execute "cd #{current_path} && (export RACK_ENV=#{fetch(:rails_env)} ; ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec pumactl -P tmp/pids/server.pid stop)"
#       end
#     end
#   end

#   def app_status
#     ps = JSON.parse(capture "forever list | grep #{fetch(:app_name)} | wc -l")
#     if ps == 1
#       return "running"
#     else
#       return "inactive"
#     end
#   end

#   set :puma_pid, "/var/www/dep-puma-app/shared/tmp/pids/server.pid"
#   set :puma_conf, "/var/www/dep-puma-app/current/config/puma.rb"

#   task :restart_puma do

#     on roles(:app) do
#       within current_path do
#         if test "[ -f #{fetch(:puma_pid)} ]" and test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
#           execute "cd #{current_path} && (export RACK_ENV=#{fetch(:rails_env)} ; ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec pumactl -S #{fetch(:puma_state)} -F #{fetch(:puma_conf)} start)"
#         else
#           invoke 'deploy:start_puma'
#         end
#       end
#       # within current_path do
#       #   execute "cd #{current_path} && (export RACK_ENV=#{fetch(:rails_env)} ; ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec pumactl -P tmp/pids/server.pid restart)"
#       #   # execute "cd #{current_path} && (export RACK_ENV=#{fetch(:rails_env)} ; ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec pumactl -S #{current_path}/tmp/pids/puma.state -F #{current_path}/puma.rb restart)"
#       # end
#     end
#   end

#   before :updated, "deploy:bundle_dependencies"
#   after :updated, "deploy:asset_precompile"
#   after :updated, "deploy:migrate_database"
#   after :published, "deploy:start_puma"
# end
