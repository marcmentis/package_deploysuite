Feature: deployer clones new app - part 2

	To automate finishing the setup of a newly cloned repo branch, a deployer will 'CD' INTO THE ROOT DIRECTORY of the newly cloned branch and run deploysuites' 'clone_new_app2' command. The deployer must belong to the 'final_deploy_group' on the server. Appropriate 'bundler', 'rails', 'rake', 'git', and 'bash' commands will be used to perform all steps necessary to complete the new clone, create db tables/SQL script [optional], and app tests [optional]. 

	The 'clone_new_app2' command has one required global flag [--host_path], and three optional local switches [--db], [--rspec], [--cucumber]

	Usage example: $ deploysuite --host_path=/path/to/host clone_new_app2 [--db] [--rspec] [--cucumber]

	The 'clone_new_app' command will perform the following functions:
		1. Run the 'bundle' command for the production environment
		2. Precompile Assets for the app
		3. Load database schema (optional)
		FOR UPDATE NOT NEW_CLONE Setup database (optional):
			Command flag controls if db setup should occur, and if so whether database should be created or just SQL code generated 
			(i) For Dev - run rake 'db:shcema:load' command
			(ii) For QA and Prod - Generate the SQL code for DB creation
		4. Make first commit to local git repo on server
		5. Start Application
		6. Run Rspec unit test
		7. Run Cucumber behavioral tests


	Scenario: 'clone_new_app2' command functions
		Given deploysuite started in app root directory
		Then send message to update gems (bundle)
		Then send message to precompile assets
		Then send message to loads db schema
		Then send message to make first commit
		Then send message to start application
		Then send message to run rspec tests
		Then send message to run cucumber tests
		Then send message to create SQL schema structure