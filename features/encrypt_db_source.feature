Feature: encryptor extracts and encrypts data from rails_database_source.yml

	To automate encryption of the correct parts of the rails_database_source.yml file onto the server, an encryptor will run deploysuites' 'encrypt_db_source' command. The encryptor must belong to the 'railsenc' group on the server. Using Ruby's YAML functionality, the data appropriate for the current server will be removed from the rails_database_source.yml file, encrypted using the AES-256-CBC algorithm, and placed in the /rails/.config/enc_database.yml file.

	The 'encrypt_db_source' command will perform the following functions:
		1. Load the rails_database_source.yml file using 'YAML.load'
		2. Extract data from the 'common' and appropriate branch (dev/qa/prod) keys
		3. Merge the 'common' and 'branch' data
		4. Encrypt the merged data using AES-256-CBC
		5. Write out the encrypted data into /rails/.config/enc_database.yml file



	Scenario: 'encrypt_db_source' command functions
		Given user belongs to railsenc group
		Then send message to extract and encrypt data from database source