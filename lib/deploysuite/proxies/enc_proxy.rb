module Deploysuite
	class EncProxy

		def encrypt_from_db_source(deploy_level, enc_config_path)

			# Get paths to relevant encryption config files
			enc_paths = YAML.load(File.read(enc_config_path))
			cipher_source_yml = enc_paths['paths']['cipher_source_yml']
			database_source_yml = enc_paths['paths']['database_source_yml']
			temp_db_sourc_yml = enc_paths['paths']['temp_db_sourc_yml']
			enc_database_yml = enc_paths['paths']['enc_database_yml']
			decryption_test_yml = enc_paths['paths']['decryption_test_yml']


			# Get Common and Appropriate data for deploy_level from database_source.yml
			db_values = YAML.load(File.read(database_source_yml))
			common_hash = db_values.fetch('common')
			deploy_level_hash = db_values.fetch(deploy_level)
			merged_hash = common_hash.merge!(deploy_level_hash)
			merged_hash_to_yaml = merged_hash.to_yaml
				# puts "DbValues: \n #{DbValues}"			
				# puts "common_hash:\n #{common_hash}"			
				# puts "deploy_level_hash: \n #{deploy_level_hash}"			
				# puts "merged_hash: \n #{merged_hash}"			
				# puts "merged_hash_to_yaml: \n #{merged_hash_to_yaml}"

			# Create a temp file containing encryption data relevant for deploy_level
			File.open(temp_db_sourc_yml, 'w') do |f|
				f.write(merged_hash_to_yaml)
			end

			# Get Key, iv, and algorithym from rails_cipher_source.yml
				cipher_params = get_cipher_params(cipher_source_yml)
				

			# Encrypt the temp file to create enc_database.yml file. 
			# Create instance of cipher for encrypting
				cipher = OpenSSL::Cipher.new(cipher_params[:alg])
				cipher.encrypt
				cipher.key = cipher_params[:key]
				cipher.iv = cipher_params[:iv]

				# aes encode database.yml into enc_database.yml file.
				#?? Set chown & chmod of ENCRYPTED_FILE
				File.open(enc_database_yml, 'wb') do |enc|
					File.open(temp_db_sourc_yml) do |f|
						loop do
							r = f.read(4096)
							break unless r							
							encoded = cipher.update(r)
							enc << encoded							
						end
					end
					enc << cipher.final
				end
			# Remove the temp file
			File.delete(temp_db_sourc_yml)

			# Test decode
				# Create decipher instance with "alg" characteristics
					decipher = OpenSSL::Cipher.new(cipher_params[:alg])
					decipher.decrypt
					decipher.key = cipher_params[:key]
					decipher.iv = cipher_params[:iv]
				# Decode enc_application.yml file into dec_test.yml file
					File.open(decryption_test_yml, 'wb') do |dec|
					    File.open(enc_database_yml, 'rb') do |f|
					        loop do
					            r = f.read(4096)
					            break unless r
					            decoded = decipher.update(r)
					            dec << decoded
					        end
					    end
					    dec << decipher.final
					end				
		end

		def get_cipher_params(cipher_source_yml)
			cipher_params = YAML.load(File.read(cipher_source_yml))
			key = cipher_params['key']
			iv = cipher_params['iv']
			alg =cipher_params['alg']
				# puts "key: #{key}"
				# puts "iv: #{iv}"
				# puts "alg: #{alg}"
			return {key: key, iv: iv, alg: alg}
		end
	end
end