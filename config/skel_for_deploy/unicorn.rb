APP_PATH = "/var/rails/planets_production"

worker_processes 4
working_directory APP_PATH + '/current'
listen APP_PATH + "/shared/tmp/sockets/unicorn.sock"
pid APP_PATH + "/shared/tmp/pids/unicorn.pid"
stderr_path APP_PATH + "/shared/log/unicorn.stderr.log"
stdout_path APP_PATH + "/shared/log/unicorn.stdout.log"

preload_app true
check_client_connection false

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && old_pid != server.pid
    begin
      Process.kill(:QUIT, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end