Sidekiq.configure_server do |config|
  config.redis = {
    url: 'redis://localhost:6379/12',
    namespace: 'dep_puma_staging'
  }
end
 
Sidekiq.configure_client do |config|
  config.redis = {
    url: 'redis://localhost:6379/12',
    namespace: 'dep_puma_staging'
  }
end
