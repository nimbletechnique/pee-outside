set :application, "peeoutside"
set :user, "collin"
set :host, "#{user}@peeoutside.org"

set :scm, :git
set :repository, "git@github.com:oculardisaster/pee-outside.git"

set :deploy_to, "/var/www/apps/#{application}"
set :runner, user
set :ssh_options, { :forward_agent => true }
set :branch, "master"

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

after 'deploy:finalize_update' do
  # run "cp #{deploy_to}/shared/database.yml #{latest_release}/config"
end
