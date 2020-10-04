# README

Set file shared/puma.rb if using without_lib branch

```ruby
#!/usr/bin/env puma

directory '/var/www/dep-puma-app/current'
rackup "/var/www/dep-puma-app/current/config.ru"
environment 'staging'

tag ''

pidfile "/var/www/dep-puma-app/shared/tmp/pids/puma.pid"
state_path "/var/www/dep-puma-app/shared/tmp/pids/puma.state"
stdout_redirect '/var/www/dep-puma-app/shared/log/puma_error.log', '/var/www/dep-puma-app/shared/log/puma_access.log', true

threads 0,8

bind 'unix:///var/www/dep-puma-app/shared/tmp/sockets/puma.sock'

workers 0
```
```shell
cap staging deploy:check
cap staging deploy
```
