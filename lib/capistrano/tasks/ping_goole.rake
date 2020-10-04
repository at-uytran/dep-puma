namespace :custom do
  task :ping_google do
    on roles(:app) do
      execute "ping google.com"
    end
  end

  task :check_puma_state do
    on roles(:app) do
      execute "ps -aux | grep puma"
    end
  end
end
