# Usage: bundle exec unicorn_rails -l 3000 -c proc/unicorn.rb

worker_processes 8

before_fork do |server, worker|
  sleep 1
end
