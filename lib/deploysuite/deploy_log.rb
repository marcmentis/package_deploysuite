module Deploysuite
	class DeployLog
		env_values = EnvValues.new
		USER = env_values.user


		def self.stderr_log
			# User = @ev.user
			if @logger.nil?
				@logger = Logger.new "/rails/log/err_log.txt"
				@logger.level = Logger::WARN
				@logger.datetime_format = '%Y-%m-%d %H:%M:%S '
				@logger.progname = "#{USER}: #{$global_host}"
			end
			@logger
		end

		def self.stdout_log
			if @logger2.nil?
				@logger2 = Logger.new "/rails/log/audit_log.txt"
				@logger2.level = Logger::DEBUG
				@logger2.datetime_format = '%Y-%m-%d %H:%M:%S '
				@logger2.progname = "#{USER}: #{$global_host}"
			end
			@logger2
		end
	end		
end