module Deploysuite
	class EncProxy
		def encrypt_file
			Enc_params = YAML.load(File.read(enc_params_yaml_file))
			key = Enc_params['key']
			iv = Enc_params['iv']
			alg =Enc_params['alg']

			# Create instance of cipher for encrypting
			cipher = OpenSSL::Cipher.new(alg)
			cipher.encrypt
			cipher.key = key
			cipher.iv = iv

			# aes encode NAME_APPLICATION_YML into <name>_enc_application.yml file.
			#?? Set chown & chmod of ENCRYPTED_FILE
			File.open(ENCRYPTED_FILE, 'wb') do |enc|
				File.open(NAME_APPLICATION_YML) do |f|
					loop do
						r = f.read(4096)
						break unless r
						#Enter Database information
							r.sub!('database1_name', DATABASE1_NAME)
							r.sub!('user1_name', USER1_NAME)
							r.sub!('password1', PASSWORD1)
						encoded = cipher.update(r)
						enc << encoded
						
					end
				end

				enc << cipher.final
			end

		end

		def get_enc_params(enc_params_yaml_file)
			Enc_params = YAML.load(File.read(enc_params_yaml_file))
			key = Enc_params['key']
			iv = Enc_params['iv']
			alg =Enc_params['alg']
			return {key: key, iv: iv, alg: alg}
		end
	end
end