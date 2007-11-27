set :runner, 'peeoutside'
set :application, "peeoutside"
set :use_sudo, false
set :checkout, "export"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :deploy_to, "/home/peeoutside/peeoutside.org"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :repository,  "http://svn.gluedtomyseat.com/peeoutside"
set :svn_user, 'peeoutside'
set :svn_password, 'peeoutsideok'

role :app, 'peeoutside@peeoutside.org'
role :web, 'peeoutside@peeoutside.org'
role :db,  'peeoutside@peeoutside.org', :primary => true