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
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C #{deploy_to}/shared/production_config.yml start"
  end
 
  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C #{deploy_to}/shared/production_config.yml stop"
  end
 
  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end
 
  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    deploy.update
    deploy.start
  end
end



after 'deploy:update_code' do
  ["database", "admin"].each do |name|
    run "cp #{deploy_to}/shared/#{name}.yml #{release_path}/config"
  end
end

