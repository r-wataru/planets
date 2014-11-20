lock '3.2.1'

set :application, 'planets'
set :repo_url, 'git@github.com:r-wataru/planets.git'
set :log_level, :info
set :linked_files, %w{ config/database.yml config/secrets.yml }
set :linked_dirs, %w{
  log tmp/pids tmp/cache tmp/sockets config/unicorn
  vendor/bundle public/system public/fonts
}
set :migration_role, 'migrator'
set :conditionally_migrate, true
#set :maintenance_template_path, 'app/views/system/maintenance.html.erb'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
  
  after :publishing, :restart

  desc 'Stop and restart application'
  task :stop_and_restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'maintenance:enable'
      invoke 'unicorn:stop'
      sleep(5)
      invoke 'unicorn:restart'
      invoke 'maintenance:disable'
    end
  end

  desc 'deploy with enabling maintenance page'
  task :upgrade do
    on roles(:app, :db), in: :sequence, wait: 5 do
      invoke 'maintenance:enable'
      invoke 'deploy'
      invoke 'maintenance:disable'
    end
  end
end
