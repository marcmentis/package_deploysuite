require 'spec_helper'

module Deploysuite
	describe Validator do
	context "Check that:" do
		it "deployer belongs to final_deployer_group" do
			v = Validator.new
			user = 'testuser'
			user_group = "railsdep omhdep omh_pilg_dep oasasdep"
			host_path = "/rails/omh/testapp"

			result = v.in_final_deployer_group?(user, user_group, host_path)
			expect(result).to eq true
		end
		it "path to host legal" do
			v = Validator.new
			host_path = "/rails/omh/app1"
			result = v.path_to_host_legal?(host_path)
			expect(result).to eq true
		end
		it "clone command requires that app not exist" do
			if Dir.exists?("/tmp/xyz")
				`rm -Rf /tmp/xyz`
			end
			v = Validator.new
			host_path = "/tmp/xyz"
			result = v.app_not_exist?(host_path)
			expect(result).to eq true
		end
		# it "repo exists and user has rights" do
		# 	pending("stub the command to github")
		# 	# v = Validator.new
		# 	# repo = "?"
		# 	# result = v.repo_exists?(repo)
		# 	# expect(result).to eq false
		# end
		it "secret Config file exists" do
			`touch /rails/testapp_enc_application.yml`
			v = Validator.new
			host_path = "/rails/testapp"
			result = v.secret_config1?(host_path)
			`rm /rails/testapp_enc_application.yml`
			expect(result).to eq true
		end
		it "can determine final_deployer_group" do
			v = Validator.new
			host_path = "/rails/omh/testapp"
			result = v.get_final_deployer_group(host_path)
			expect(result).to eq "omhdep"
		end

	end
	end
end