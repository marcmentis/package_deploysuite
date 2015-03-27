Feature: deployer updates existing app

	To automate updating an existing application, a deployer will 'cd' INTO THE ROOT DIRECTORY of the app and run deploysuites' 'update_app' command with an appropriate message (-m flag). The deployer must belong to the 'final_deploy_group' on the server. Appropriate 'bundler', 'rails', 'rake', 'git', and 'bash' commands will be used to, perform all steps necessary for updating the app, add new encrypted db file (if new schema added), [optional], change any db tables/ creating SQL script [optional] and running tests [optional]

	The 'update_app' command has one required global flag [--host_path], one required flag [-m] (update message), and three optional local switches [--db] (change db), [--rspec] (run rspec tests), [--cucumber] (run cucumber tests)

	Usage example: $ deploysuite --host_path=/path/to/host update_app -m "Add function" [--encrypted_file] [--db] [--rspec] [--cucumber]

	The 'update_app' command will perform the following functions:
		1. Check that 'deploysuite' is run from app root
		2. Fetch the appropriate branch from the app (origin repo) and quit 'deploysuite' if branch already up to date
		3. Move encrypted db file (from /rails/<encrypted_file>) into app [optional]
		4. Remove (clobber) existing precompiled assets
		5. Stash any local changes		
		6. Merge the fetched branch with the appropriate local branch
		7. Update gems with 'bundle' command 
		8. Precompile assets 	
		9. Make changes to db tables (DEV server)/ Create SQL script of changes (QA, PROD servers) [optional]
		10. Restart app
		11. Set group privileges
		12. Run RSpec unit tests [optional]
		13. Run Cucumber behavioral tests [optional]
	
	Scenario: 'update_app' command functions
		Given deploysuite started in app root directory
		Then send message to fetch appropriate branch from origin
		Then send message to check if new encrypted file exists
		Then send message to move new encrypted db file into app
		Then send message to clobber assets
		Then send message to stash local changes 		
		Then send message to merge fetched branch with appropriate local branch
		Then send message to update gems (bundle)
		Then send message to precompile assets		
		Then send message to make changes to DEV db tables
		Then send messsage to make changes to QA/PROD db tables
		Then send message to start application

		Then send message to set group ownership and privileges for owned files
		
		Then send message to run rspec tests
		Then send message to run cucumber tests