module Deploysuite
	class EncProxy

		def encrypt_from_db_source
			# # Will get this from proxies
			# CipherSourceYml = 'rails_cipher_source.yml'
			# DatabaseSourceYml = 'rails_database_source.yml'
			# EncDatabaseYml = 'enc_database.yml'
			# Branch = 'dev'

			# # Get Common and Appropriate branch
			# DbValues = YAML.load(File.read(DatabaseSourceYml))
			# # puts "DbValues: \n #{DbValues}"
			# Common = DbValues.fetch('common')
			# # puts "Common:\n #{Common}"
			# branch_hash = DbValues.fetch(Branch)
			# # puts "branch_hash: \n #{branch_hash}"
			# Merged = Common.merge!(branch_hash)
			# # puts "Merged: \n #{Merged}"
			# MergedToYaml = Merged.to_yaml
			# # puts "MergedToYaml: \n #{MergedToYaml}"

			# File.open('temp_branch.yml', 'w') do |f|
			# 	f.write(MergedToYaml)
			# end



			# # Get Key, iv, and algorithym from rails_cipher_source.yml
			# 	CipherParams = YAML.load(File.read(CipherSourceYml))
			# 	key = CipherParams['key']
			# 	iv = CipherParams['iv']
			# 	alg =CipherParams['alg']

			# # Create the enc_database.yml file. DB GROUP FUNCTION
			# # Create instance of cipher for encrypting
			# 	cipher = OpenSSL::Cipher.new(alg)
			# 	cipher.encrypt
			# 	cipher.key = key
			# 	cipher.iv = iv

			# 	# aes encode database.yml into enc_database.yml file.
			# 	#?? Set chown & chmod of ENCRYPTED_FILE
			# 	File.open(EncDatabaseYml, 'wb') do |enc|
			# 		File.open('temp_branch.yml') do |f|
			# 			loop do
			# 				r = f.read(4096)
			# 				break unless r
								
			# 				encoded = cipher.update(r)
			# 				enc << encoded
							
			# 			end
			# 		end

			# 		enc << cipher.final
			# 	end
			# # Remove the temp branch .yml file
			# File.delete('temp_branch.yml')

			# # Test decode
			# 	# Create decipher instance with "alg" characteristics
			# 		decipher = OpenSSL::Cipher.new(alg)
			# 		decipher.decrypt
			# 		decipher.key = key
			# 		decipher.iv = iv
			# 	# Decode enc_application.yml file into dec_test.yml file
			# 		File.open('de-encryption_test.yml', 'wb') do |dec|
			# 		    File.open(EncDatabaseYml, 'rb') do |f|
			# 		        loop do
			# 		            r = f.read(4096)
			# 		            break unless r
			# 		            decoded = decipher.update(r)
			# 		            dec << decoded
			# 		        end
			# 		    end

			# 		    dec << decipher.final
			# 		end	

			
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