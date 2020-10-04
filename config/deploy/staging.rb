set :branch, :without_lib
set :deploy_to, '/var/www/dep-puma-app'
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :stage, :staging
set :rails_env, :staging

server '54.173.15.218', user: 'uytv2', roles: %w{web app db}

namespace :deploy do
  task :bundle_dependencies do
    on roles(:app) do
      within release_path do
        execute "cd #{release_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle install --path /var/www/dep-puma-app/shared/bundle"
      end
    end
  end

  task :asset_precompile do
    on roles(:app) do
      within release_path do
        execute "cd #{release_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec rake assets:precompile"
      end
    end
  end

  task :migrate_database do
    on roles(:db) do
      within release_path do
        execute "cd #{release_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec rake db:migrate RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end

  task :start_puma do
    on roles(:all) do
      within current_path do
        execute "export RAILS_ENV=#{fetch(:rails_env)} ; cd #{current_path} && ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec puma -C #{shared_path}/puma.rb --daemon"
      end
    end
  end

  task :stop_puma do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path} && (export RAILS_ENV=#{fetch(:rails_env)} ; ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec pumactl -S #{shared_path}/tmp/pids/puma.state -F #{shared_path}/puma.rb stop)"
      end
    end
  end

  set :puma_pid, "/var/www/dep-puma-app/shared/tmp/pids/puma.pid"
  set :puma_conf, "/var/www/dep-puma-app/shared/puma.rb"

  task :restart_puma do
    on roles(:all) do
      within current_path do
        if test "[ -f #{fetch(:puma_pid)} ]" and test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
          execute "export RAILS_ENV=#{fetch(:rails_env)} ; cd /var/www/dep-puma-app/current/ && ~/.rvm/bin/rvm ruby-2.5.3 do bundle exec pumactl -S #{shared_path}/tmp/pids/puma.state -F #{shared_path}/puma.rb restart"
        else
          invoke "deploy:start_puma"
        end
      end
    end
  end

  before :updated, "deploy:bundle_dependencies"
  after :updated, "deploy:asset_precompile"
  after :updated, "deploy:migrate_database"
end

before "deploy:finished", "deploy:restart_puma"
