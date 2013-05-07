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
		
=begin
TODO
needs code to check whether it's already been run and give warning if so
=end

		# Populate neo4j with first-run data
		# Only do this once unless you wipe your database between runs
		# Neography only supports creating indexes using "Phase 1"
		@neo4j = Neography::Rest.new

		# Create indices
		@neo4j.create_node_index(TYPE_INDEX)
		@neo4j.create_node_index(ID_INDEX)
		@neo4j.create_node_index(CHARITY_NAME_INDEX)
		@neo4j.create_node_index(CHARITY_EIN_INDEX)
		@neo4j.create_node_index(DONOR_EMAIL_INDEX)
		@neo4j.create_node_index(DONOR_TOKEN_INDEX)
		@neo4j.create_node_index(ENDOWMENT_NAME_INDEX)
		@neo4j.create_node_index(SHARE_INDEX)

		# Create sponsor organization, add to index for easy retrieval later
		sponsoring_organization = Neography::Node.create( "id" => generate_unique_id(), "name"=>SPONSOR_ORGANIZATION_NAME, "domain"=>SPONSOR_ORGANIZATION_DOMAIN)
		sponsoring_organization.add_to_index(ID_INDEX, ID_INDEX, sponsoring_organization.id)
		sponsoring_organization.add_to_index(TYPE_INDEX, TYPE_INDEX, SPONSOR_ORGANIZATION_TYPE)

		# Create first investment fund, add to index for easy retrieval later
		investment_fund = Neography::Node.create( "id" => generate_unique_id(), "name"=>INVESTMENT_FUND_NAME)
		investment_fund.add_to_index(ID_INDEX, ID_INDEX, investment_fund.id)
		investment_fund.add_to_index(TYPE_INDEX, TYPE_INDEX, INVESTMENT_FUND_TYPE)

		# Create Processor node
		processor = Neography::Node.create( "id" => generate_unique_id(), "name"=>PROCESSOR_NAME, "fee_threshold"=>"10.00", "fee"=>"0.25")
		processor.add_to_index(ID_INDEX, ID_INDEX, processor.id)
		processor.add_to_index(TYPE_INDEX, TYPE_INDEX, PROCESSOR_TYPE)
	end # task
end # namespace



