module Deploysuite
	class EncProxy

		def encrypt_from_db_source
			# # Will get this from proxies
			# CipherSourceYml = 'rails_cipher_source.yml'
			# DatabaseSourceYml = 'rails_database_source.yml'
			# EncDatabaseYml = 'enc_database.yml'
			# Branch = 'dev'
			cipher_source_yml = '/rails/.config/rails_cipher_source.yml'
			database_source_yml = '/rails/.config/rails_database_source.yml'
			temp_db_sourc_yml = '/rails/.config/temp_branch.yml'
			enc_database_yml = '/rails/.config/enc_database.yml'
			branch = 'dev'

			decryption_test_yml = '/rails/.config/de-encryption_test.yml'

			# Get Common and Appropriate branch
			db_values = YAML.load(File.read(database_source_yml))
			# puts "DbValues: \n #{DbValues}"
			common_hash = db_values.fetch('common')
			puts "common_hash:\n #{common_hash}"
			branch_hash = db_values.fetch(branch)
			puts "branch_hash: \n #{branch_hash}"
			merged_hash = common_hash.merge!(branch_hash)
			puts "merged_hash: \n #{merged_hash}"
			merged_hash_to_yaml = merged_hash.to_yaml
			puts "merged_hash_to_yaml: \n #{merged_hash_to_yaml}"

			File.open(temp_db_sourc_yml, 'w') do |f|
				f.write(merged_hash_to_yaml)
			end



			# Get Key, iv, and algorithym from rails_cipher_source.yml
				cipher_params = YAML.load(File.read(cipher_source_yml))
				key = cipher_params['key']
				iv = cipher_params['iv']
				alg =cipher_params['alg']

				puts "key: #{key}"
				puts "iv: #{iv}"
				puts "alg: #{alg}"

			# Create the enc_database.yml file. DB GROUP FUNCTION
			# Create instance of cipher for encrypting
				cipher = OpenSSL::Cipher.new(alg)
				cipher.encrypt
				cipher.key = key
				cipher.iv = iv

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
			# # Remove the temp branch .yml file
			File.delete(temp_db_sourc_yml)

			# Test decode
				# Create decipher instance with "alg" characteristics
					decipher = OpenSSL::Cipher.new(alg)
					decipher.decrypt
					decipher.key = key
					decipher.iv = iv
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

		def get_enc_params(enc_params_yaml_file)
			# Enc_params = YAML.load(File.read(enc_params_yaml_file))
			# key = Enc_params['key']
			# iv = Enc_params['iv']
			# alg =Enc_params['alg']
			# return {key: key, iv: iv, alg: alg}
		end
	end
end