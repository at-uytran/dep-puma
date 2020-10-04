namespace :custom do
  task :curl_google do
    on roles(:app) do
      execute "curl google.com"
    end
  end

  task :check_puma_state do
    on roles(:app) do
      execute "ps -aux | grep puma"
    end
  end

  task :ask_your_name do
    ask(:your_name, "guess")
    on roles(:app) do
      execute("echo \"$(whoami) Hello #{fetch(:your_name)}\"")
    end
  end
end