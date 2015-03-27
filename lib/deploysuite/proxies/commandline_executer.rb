
module CommandlineExecuter
	def open3method(cmd, out=false)

		stdout_str, stderr_str, status = Open3.capture3(cmd)
		unless status.exitstatus == 0
			DeployLog.stderr_log.fatal {stderr_str}
		    # STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
		    $stderr.puts Rainbow("ERROR: #{stderr_str} ").red
		    exit 1	
		end

		unless out == false
			# STDOUT.puts stdout_str
			output = "#{stdout_str}\n#{stderr_str}"
	    	# STDOUT.puts output
	    	$stdout.puts output
		end	

		return {stdout: stdout_str, stderr: stderr_str, status: status, exit: status.exitstatus}	
	end
end