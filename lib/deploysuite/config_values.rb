module ConfigValues

	def get_paths_from_rails_ymlfiles_yml(ymlfiles_yml)
		ymlfile_paths = YAML.load(File.read(ymlfiles_yml))
		db_yml = ymlfile_paths[:paths][:db_yml]
		cipher_yml = ymlfile_paths[:paths][:cipher_yml]
		temp_db_yml = ymlfile_paths[:paths][:temp_db_yml]
		encrypted_db_yml = ymlfile_paths[:paths][:encrypted_db_yml]
		decryption_test_yml = ymlfile_paths[:paths][:decryption_test_yml]
		machines_path = ymlfile_paths[:paths][:machine_deploy_levels]
		return {db_yml: db_yml, cipher_yml: cipher_yml, temp_db_yml: temp_db_yml,encrypted_db_yml: encrypted_db_yml, decryption_test_yml: decryption_test_yml, machines_path: machines_path}
	end

	def get_machines_at_deploy_levels(ymlfiles_yml)
		ymlfile_paths = get_paths_from_rails_ymlfiles_yml(ymlfiles_yml)
		machines_path = ymlfile_paths[:machines_path]

		machines = YAML.load(File.read(machines_path))
		dev_machines = machines[:machine_deploy_levels][:dev]
		qa_machines = machines[:machine_deploy_levels][:qa]
		prod_machines = machines[:machine_deploy_levels][:prod]

		return {dev_machines: dev_machines, qa_machines: qa_machines, prod_machines: prod_machines}
	end
			
end