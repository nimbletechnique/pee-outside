set :runner, 'peeoutside'
set :application, "peeoutside"
set :use_sudo, false
set :checkout, "export"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :deploy_to, "/users/home/peeoutside/rails/peeoutside"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

# repo is localhost on this deployment
set :repository,  "svn+ssh://peeoutside@8.17.86.51/home/peeoutside/svn/repo"
set :svn_user, 'peeoutside'
set :svn_password, 'p330uts1d3'

role :app, 'peeoutside@peeoutside.org'
role :web, 'peeoutside@peeoutside.org'
role :db,  'peeoutside@peeoutside.org', :primary => true