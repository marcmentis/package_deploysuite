require "spec_helper"

module Deploysuite
	describe Runner do

		context "Message from Runner to RailsProxy to:" do
			before(:each) do
				@RailsProxy = double()  # RailsProxy object
				# Pass RailsProxy double into Runner
					#Runner takes any arg & uses dependency injection			
				@r = Runner.new(rails_proxy: @RailsProxy) 
				
			end
			
			it "perform bundle command in production env" do				
				@RailsProxy.stub(:bundle)
				@r.run_bundle()
			end


			it "precompile assets in production environment" do
				@RailsProxy.stub(:precompile_assets)
				@r.run_precompile_assets()
			end

			it "load db schema" do
				@RailsProxy.stub(:load_schema)
				@r.run_load_schema()
			end

			it "generate SQL script for migration" do
				@RailsProxy.stub(:generate_sql_script)
				@r.run_generate_sql_script()
			end

			it "generate SQL script for schema" do
				@RailsProxy.stub(:db_structure_dump)
				@r.run_db_structure_dump
			end

			it "run rspec tests" do
				@RailsProxy.stub(:rspec_tests)
				@r.run_rspec_tests
			end

			it "run cucumber tests" do
				@RailsProxy.stub(:cucumber_tests)
				@r.run_cucumber_tests
			end

			it "clobbers assets" do
				@RailsProxy.stub(:clobber_assets)
				@r.run_clobber_assets
			end
		end

		context "Message from Runner to GitProxy to:" do
			before(:each) do
				@GitProxy = double()  # GitProxy object
				# Pass GitProxy double into Runner
					#Runner takes any arg & uses dependency injection			
				@r = Runner.new(git_proxy: @GitProxy) 
			end
			it "perform first commit" do
				@GitProxy.stub(:first_commit)
				@r.run_first_commit()
			end

			it "clone the appropriate branch" do
				@GitProxy.stub(:clone_branch)
				r = Runner.new(git_proxy: @GitProxy, validator: Validator.new, env_values: EnvValues.new)
				r.run_clone_branch('stub-repo', 'stub-host_path')
			end
		end

		context "Message from Runner to UtilProxy to:" do
			before(:each) do
				@UtilsProxy = double()  #UtilProxy object
				@r = Runner.new(utils_proxy: @UtilsProxy)
			end
			it "(re)start application" do
				@UtilsProxy.stub(:start_application)
				@r.run_start_application()
			end
		end		
		
	end
end