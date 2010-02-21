set :application, "peeoutside"
set :user, "deploy"
set :host, "#{user}@nimbletechnique.com"

set :scm, :git
set :repository, "git@github.com:nimbletechnique/pee-outside.git"

set :deploy_to, "/var/www/apps/#{application}"
set :runner, user
set :ssh_options, { :forward_agent => true }
set :branch, "master"

set :use_sudo, false

role :app, "#{host}"
role :web, "#{host}"
role :db,  "#{host}", :primary => true

namespace :deploy do
  
  task :start do
    run "unicorn_rails --daemonize --env production --config-file #{deploy_to}/shared/unicorn.conf"
  end
  
  task :stop do
    run "kill `cat #{deploy_to}/shared/pids/unicorn.pid`"
  end
  
  task :restart do
    run "kill -USR2 `cat #{deploy_to}/shared/pids/unicorn.pid`"
  end
end

after 'deploy:update_code' do
  ["database", "admin"].each do |name|
    run "cp #{deploy_to}/shared/#{name}.yml #{release_path}/config"
  end
end

