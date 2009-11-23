set :application, "peeoutside"
set :user, "deploy"
set :host, "#{user}@68.68.97.194"

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
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after 'deploy:update_code' do
  ["database", "admin"].each do |name|
    run "cp #{deploy_to}/shared/#{name}.yml #{release_path}/config"
  end
end

