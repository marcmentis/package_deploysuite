module Deploysuite
	class RepoBranchSwitcher
		attr_reader :v, :ev, :git_branch, :ymlfiles_path

		def initialize(args={})
			@v = args[:validator]
			@ev = args[:env_values]
			@ymlfiles_path = args[:ymlfiles_path]
			@git_branch = get_git_branch
		end
		

		def get_git_branch
			git_branch = v.get_git_branch(ev.machine_name, ymlfiles_path)
		end

		def send(switch_info={})
			args = switch_info[:args]
			command = switch_info[:command]
			

			case git_branch
			    when "dev"
			    	# puts "In dev"
			    	dev = DevDeployer.new({runner: Runner.new(rails_proxy: RailsProxy.new, validator: Validator.new, env_values: EnvValues.new, git_proxy: GitProxy.new, utils_proxy: UtilsProxy.new, encryptor: Encryptor.new)})
					whole_message = "dev.#{command}(#{args})"
					eval(whole_message)
			    when "qa"
			    	# puts "In qa"
			    	qa = QaDeployer.new({runner: Runner.new(rails_proxy: RailsProxy.new, validator: Validator.new, env_values: EnvValues.new, git_proxy: GitProxy.new, utils_proxy: UtilsProxy.new, encryptor: Encryptor.new)})
			    	whole_message = "qa.#{command}(#{args})"
					eval(whole_message)
			    when "master"
			    	# puts "In prod"
			    	prod = ProdDeployer.new({runner: Runner.new(rails_proxy: RailsProxy.new, validator: Validator.new, env_values: EnvValues.new, git_proxy: GitProxy.new, utils_proxy: UtilsProxy.new, encryptor: Encryptor.new)})
			    	whole_message = "prod.#{command}(#{args})"
					eval(whole_message)
			    else
			      STDERR.puts Rainbow("ERROR: This machine '#{ev.machine_name}' does NOT have permission to run this app.").red
			      exit 1
		    end		
		end
		

	
		
	end
end