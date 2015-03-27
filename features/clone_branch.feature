Feature: deployer clones the appropriate repo branch into a server 

	To automate cloning the correct application branch onto the appropriate server, a deployer will run deploysuites' 'clone_branch' command. 

	This is a 'plumbing' command. Is one step in "clone_new_app" command. No validations are performed prior to running the task. That is, if the deployer enters an illegal path or repo no checks will be performed before running the command

	The 'clone_branch' command takes the 'host_path' to the new app as a global flag, and the repo URL as a command flag. 

	Usage example: $ deploysuite --host_path=/path/to/host clone repo/url

	Scenario: 'clone_branch' command runs successfully
		Given app /tmp/test_app does not exist
		When I successfully run `deploysuite --host_path=/tmp/test_app clone_branch -r 'git@github.com:marcmentis/trash1.git'` 
		Then the stdout should contain "Success: "
		Then remove app /tmp/test_app


		


