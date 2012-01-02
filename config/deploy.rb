require "bundler/capistrano"

set :application, "voicebox"
set :repository,  "git@github.com:glards/Voicebox.git"
set :deploy_to, "/home/www/voicebox/approot"

set :user, 'deploy'

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "voicebox.poufpouf.net"                          # Your HTTP server, Apache/etc
role :app, "voicebox.poufpouf.net"                          # This may be the same as your `Web` server
role :db,  "voicebox.poufpouf.net", :primary => true # This is where Rails migrations will run

default_environment["PATH"]         = "/usr/local/rvm/gems/ruby-1.9.2-p290/bin:/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin:/usr/local/rvm/rubies/ruby-1.9.2-p290/bin:/usr/local/rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"
default_environment["GEM_HOME"]     = "/usr/local/rvm/gems/ruby-1.9.2-p290"
default_environment["GEM_PATH"]     = "/usr/local/rvm/gems/ruby-1.9.2-p290:/usr/local/rvm/gems/ruby-1.9.2-p290@global"
default_environment["RUBY_VERSION"] = "ruby-1.9.2-p290"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

