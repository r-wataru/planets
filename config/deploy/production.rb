# config/deploy/production.rb

set :deploy_to, "/var/rails/planets_production"
set :branch, "master"
set :user, "wataru"
set :resettable, false
set :rails_env, "production"

role :app, ["wataru@153.121.76.219"]
role :web, ["wataru@153.121.76.219"]
role :db,  ["wataru@153.121.76.219"]

server '153.121.76.219', user: 'wataru', roles: %w{web app db}

set :ssh_options, {
  keys: %w(/Users/wataru/.ssh/id_rsa),
  forward_agent: true
}
set :bundle_cmd, "/opt/rubies/2.1.2/bin/bundle"
set :default_environment, {
  "PATH" => "/opt/rubies/2.1.2/bin:$PATH"
}