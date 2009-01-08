DEPLOY_PATH = "/home/pure2008/web/hair"

set :application, "hair"
set :repository,  "svn://svnhost.cn/hair"
set :svn_username, "pure2008"
set :svn_password, "821024"
ssh_options[:port] = 22

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "#{DEPLOY_PATH}"
set :user, "pure2008"
set :password, "pure20080611"


role :app, "202.142.26.121"
role :web, "202.142.26.121"
role :db,  "pure2008", :primary => true

 desc "Update and restart web server for www.beyondrails.com"
 task :up, :roles => :app do
   run "cd #{DEPLOY_PATH};svn up"
 end