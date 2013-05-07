require 'rake'
require 'neography/tasks'
load 'lib/initial_seed.rb'
require 'neography'
load 'config/g2g-config.rb'
load 'lib/functions.rb'


task :default => [:test]

task :test do
  ruby "test/charity_import_test.rb"
end

namespace :server do
    desc "start server"
    task :start do
        system "shotgun -p9393"
    end
end



namespace :database do
	desc "installation and setup of neo4j database. Needs user with passwordless sudo"
	task :init do
		exec("ruby lib/initial_seed.rb")
=begin
TODO
needs code to check whether it's already been run and give warning if so
=end
	end # task
end # namespace



