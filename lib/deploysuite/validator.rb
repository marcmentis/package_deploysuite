module Deploysuite
	class Validator

		# def test_from_runner(args)
		# 	args == '/tmp/testapp' ? true : false
		# end

		def app_not_exist?(host_path)
			host_path.downcase
			if Dir.exists?(host_path)
				DeployLog.stderr_log.fatal {"The app #{host_path} already exists"}
				STDERR.puts Rainbow("ERROR: The app #{host_path} already exists").red
				return false
			else
				true 
			end
		end

		def app_exists?(host_path)
			host_path.downcase
			unless Dir.exists?(host_path)
				STDERR.puts Rainbow("The app #{host_path} does not exist").red	
				return false			
			else
				true
			end
		end

		def repo_exists?(repo)
			command = "git ls-remote #{repo}"
			stdout_str, stderr_str, status = Open3.capture3(command)

			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
				STDERR.puts Rainbow(stderr_str).red	
				return false
			else
				return true		
			end
		end

		def path_to_host_legal?(host_path)
			# 'host_path' is the full path to the app i.e., /rails/omh/app1
			# 'path_to_app' is path to div that holds app i.e., /rails/omh
			path_to_host = get_path_to_host(host_path)

			case path_to_host
				when "/rails/omh", "/rails/omh/pilgrim", "/rails/oasas", "/tmp"
					true
			else
				DeployLog.stderr_log.fatal {"'#{path_to_host}' is not a legal path to an app"}
				STDERR.puts Rainbow("ERROR: '#{path_to_host}' is not a legal path to an app").red
				return false
			end
		end

		def get_git_branch(machine_name)
			case machine_name
				when "omhrord1.omh.ny.gov", "u14dev", "marcs-mbp"
					@git_branch = 'dev'
				when "omhrorq1.omh.ny.gov", "u14qa"
					@git_branch = 'qa'
				when "omhrorp1.omh.ny.gov", "u14prod"
					@git_branch = 'master'
				else
					STDERR.puts Rainbow("ERROR: This machine '#{machine_name}' does NOT have permission to run this app.").red
					exit 1
			end
		end

		def in_final_deployer_group?(user, user_groups, host_path)
			final_deployer_group = get_final_deployer_group(host_path)
			if user_groups.include? final_deployer_group
				true
			else
				DeployLog.stderr_log.fatal {"'#{user}' is not a member of '#{final_deployer_group}' group on this server"}
				STDERR.puts Rainbow("ERROR: '#{user}' is not a member of '#{final_deployer_group}' group on this server").red				
				return false
			end
		end

		def in_group?(user, user_groups, group)
			if user_groups.include? group
				true
			else
				DeployLog.stderr_log.fatal {"'#{user}' is not a member of '#{group}' group on this server"}
				STDERR.puts Rainbow("ERROR: '#{user}' is not a member of '#{group}' group on this server").red				
				return false
			end
		end

		def secret_config1?(host_path)
			app_name = get_app_name(host_path)
			secret_config1 = "#{app_name}_enc_application.yml"
			if File.exists?("/rails/#{secret_config1}")
				true
			else
				DeployLog.stderr_log.fatal {" Config file '#{secret_config1}' does not exist"}
				STDERR.puts  Rainbow("ERROR: Config file '#{secret_config1}' does not exist").red 
				return false
			end
		end


		def get_path_to_host(host_path)
			# 'host_path' is the full path to the app i.e., /rails/omh/app1
			# 'path_to_app' is path to div that holds app i.e., /rails/omh
			host_path.downcase
			host_path_array = host_path.split('/')
			host_path_array.pop
			path_to_host = host_path_array.join('/')
		end

		def get_app_name(host_path)
			host_path.downcase
			arr = host_path.split('/')
			app_name = arr.pop
		end

		def get_final_deployer_group(host_path)
			host_path.downcase
			path_to_host = get_path_to_host(host_path)
			case path_to_host
				when "/tmp"
					final_deployer_group = "omhdep"
				when "/rails/omh"
					final_deployer_group = "omhdep"
				when "/rails/omh/pilg"
					final_deployer_group = "omh_pilg_dep"
				when "/rails/oasasdep"
					final_deployer_group = "oasasdep"
				else
					DeployLog.stderr_log.fatal {" There is no deployer group associated with '#{host_path}'"}
					STDERR.puts  Rainbow("ERROR: There is no deployer group associated with '#{host_path}'").red 
			end
		end
	end
end