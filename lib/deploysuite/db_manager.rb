module Deploysuite
	class DbManager
		def create_deploy_level_db_params(deploy_level, rails_files_config)
			# Get paths to relevant db management files
			files_config = YAML.load(File.read(rails_files_config))
			db_config_yml = files_config['paths']['db_config_yml']
			temp_db_config_yml = files_config['paths']['temp_db_config_yml']


			# Get Common and Appropriate data for deploy_level from rails_db_config.yml
			db_params = YAML.load(File.read(db_config_yml))
			common_hash = db_params.fetch('common')
			deploy_level_hash = db_params.fetch(deploy_level)
			merged_hash = common_hash.merge!(deploy_level_hash)
			merged_hash_to_yaml = merged_hash.to_yaml

			# Create a temp file containing deploy_level db params
			File.open(temp_db_config_yml, 'w') do |f|
				f.write(merged_hash_to_yaml)
			end

				# puts "files_config: \n #{files_config}"
				# puts "db_config_yml: \n #{db_config_yml}"
				# puts "temp_db_config_yml: \n #{temp_db_config_yml}"	
				# puts "db_params: \n #{db_params}"			
				# puts "common_hash:\n #{common_hash}"			
				# puts "deploy_level_hash: \n #{deploy_level_hash}"			
				# puts "merged_hash: \n #{merged_hash}"			
				# puts "merged_hash_to_yaml: \n #{merged_hash_to_yaml}"
			
			
		end

		def destroy_deploy_level_db_params(rails_files_config)
			# Get paths to relevant db management files
			files_config = YAML.load(File.read(rails_files_config))
			temp_db_config_yml = files_config['paths']['temp_db_config_yml']
			File.delete(temp_db_config_yml)
		end
	end
end