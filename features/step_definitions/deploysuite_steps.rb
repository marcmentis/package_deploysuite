

When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end


# Add more step definitions here

Given(/^app \/tmp\/test_app does not exist$/) do
  	host_path = "/tmp/test_app" 
	# Check if host_path exist and remove
	if Dir.exists?(host_path)
		`rm -Rf #{host_path}`
	end
end

Given(/^secret_config1 file exists$/) do
  `touch /rails/test_app_enc_application.yml`
end

Then(/^remove app \/tmp\/test_app$/) do
  	host_path = "/tmp/test_app" 
	# Check if host_path exist and remove
	if Dir.exists?(host_path)
		`rm -Rf #{host_path}`
	end
end

Then(/^remove secret_config1 file$/) do
  `rm /rails/test_app_enc_application.yml`
end

Then(/^clone test_app$/) do
 	`touch /tmp/stdout.txt`
  	`git clone -b dev git@github.com:marcmentis/trash1.git /tmp/test_app 2>/tmp/stdout.txt`
  	`rm /tmp/stdout.txt`
end

Given(/^deploysuite started in app root directory$/) do
  #Don't do anything
end




Then(/^send message to update gems \(bundle\)$/) do
	r = double()
	r.stub(:bundle)

	runner = Runner.new(rails_proxy: r)
	runner.run_bundle()
end


Then(/^send message to precompile assets$/) do
	r = double()
	r.stub(:precompile_assets)

	runner = Runner.new(rails_proxy: r)
	runner.run_precompile_assets()
end

Then(/^send message to loads db schema$/) do
	r = double()
	r.stub(:load_schema)

	runner = Runner.new(rails_proxy: r)
	runner.run_load_schema()

end

Then(/^send message to make first commit$/) do
	g = double()
	g.stub(:first_commit)

	r = Runner.new(validator: Validator.new, env_values: EnvValues.new, git_proxy: g)
	r.run_first_commit()
end

Then(/^send message to start application$/) do
	u = double()
	u.stub(:start_application)

	runner = Runner.new(utils_proxy: u)
	runner.run_start_application()
end

Then(/^send message to run rspec tests$/) do
	r = double()
	r.stub(:rspec_tests)

	runner = Runner.new(rails_proxy: r)
	runner.run_rspec_tests
end

Then(/^send message to run cucumber tests$/) do
	r = double()
	r.stub(:cucumber_tests)

	runner = Runner.new(rails_proxy: r)
	runner.run_cucumber_tests
end

Then(/^send message to create SQL schema structure$/) do
	r = double()
	r.stub(:db_structure_dump)

	runner = Runner.new(rails_proxy: r)
	runner.run_db_structure_dump
end

Then(/^send message to clobber assets$/) do
	r = double()
	r.stub(:clobber_assets)

	runner = Runner.new(rails_proxy: r)
	runner.run_clobber_assets
end

Then(/^send message to stash local changes$/) do
  g = double()
  g.stub(:stash_local_changes)
  runner = Runner.new(git_proxy: g)
  runner.run_stash_local_changes
end

Then(/^send message to fetch appropriate branch from origin$/) do
  g = double()
  g.stub(:fetch_branch_from_origin)
  runner = Runner.new(git_proxy: g, env_values: EnvValues.new, validator: Validator.new)
  runner.run_fetch_branch_from_origin
end

Then(/^send message to merge fetched branch with appropriate local branch$/) do
  g = double()
  g.stub(:merge_fetched_branch)
  runner = Runner.new(git_proxy: g, env_values: EnvValues.new, validator: Validator.new)
  runner.run_merge_fetched_branch('message')
end

Then(/^send message to check if new encrypted file exists$/) do
  v = double()
  v.stub(:secret_config1?) {true}  # Make this message return true
  runner = Runner.new(validator: v)
  runner.run_secret_config1?('host_path')
end

Then(/^send message to move new encrypted db file into app$/) do
  u = double()
  u.stub(:move_secret_file)
  runner = Runner.new(utils_proxy: u, validator: Validator.new)
  runner.run_move_secret_file('host_path')
end

Then(/^send message to make changes to DEV db tables$/) do
  r = double()
  r.stub(:migrate_db)
  runner =Runner.new(rails_proxy: r)
  runner.run_migrate_db
end

Then(/^send messsage to make changes to QA\/PROD db tables$/) do
  r = double()
  r.stub(:generate_sql_script)
  runner = Runner.new(rails_proxy: r)
  runner.run_generate_sql_script
end

Then(/^send message to set group ownership and privileges for owned files$/) do
	u = double()
	u.stub(:set_owned_file_privileges)
	runner = Runner.new(utils_proxy: u, validator: Validator.new)
	runner.run_set_owned_file_privileges('/tmp/testapp')
end


