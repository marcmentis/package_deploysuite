#!/usr/bin/env ruby
require 'socket'
require 'open3'
require 'logger'
require 'rainbow'



		# def process_cmd(cmd,stdout=false)
			# 	stdout_str, stderr_str, status = Open3.capture3(cmd)

			# 	puts "IN process_cmd"
			# 	puts "stdout_str: #{stdout_str}"
			#     puts "stderr_str: #{stderr_str}"
			#     puts "status: #{status}"
			#     puts "status.exitstatus: #{status.exitstatus}"
				
			# 	unless status.exitstatus == 0
			# 		DeployLog.stderr_log.fatal {stderr_str}
			# 	    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			# 	    exit 1	
			# 	end

			# 	unless stdout == false
			# 		STDOUT.puts stdout_str
			# 	end
			# end

	def open3method(cmd, out=false)

		stdout_str, stderr_str, status = Open3.capture3(cmd)
		# unless status.exitstatus == 0
		# 	DeployLog.stderr_log.fatal {stderr_str}
		#     $stderr.puts Rainbow("ERROR: #{stderr_str} ").red
		#     exit 1	
		# end

		unless out == false
			# STDOUT.puts stdout_str
			output = "#{stdout_str}\n#{stderr_str}"
	    	$stdout.puts output
		end	

		return {stdout: stdout_str, stderr: stderr_str, st: status, exit: status.exitstatus}	
	end

		def first_commit
			cmd = "git add ."
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')	

			cmd = "git commit -m 'First Commit'"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')				
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')	
		end

		def rspec_tests
			cmd = "bundle exec rspec spec"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')
		end

		def fail_with_invalid_command
			cmd = "ls --rubbish"
			r=open3method(cmd)
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"
		end

		def clobber_assets
			cmd = "bundle exec rake assets:clobber RAILS_ENV=production"
			r=open3method(cmd, 'out')
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"
		end

		def stash_local_changes
			cmd = "git stash"
			r= open3method(cmd)	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"	
		end

		def fetch_branch_from_origin(git_branch)
			cmd = "git fetch -v origin #{git_branch}:refs/remotes/origin/#{git_branch}"
			r= open3method(cmd, 'out')	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"		
		end

		def merge_fetched_branch(git_branch, message)
			cmd = "git merge origin/#{git_branch} -m '#{message}' "
			r= open3method(cmd)	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"	
		end

		def migrate_db
			cmd = "bundle exec rake db:migrate RAILS_ENV=production"
			r= open3method(cmd)	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"	
		end

		def generate_sql_script
			cmd = "bundle exec rake db:schema:to_sql RAILS_ENV=production"
			r= open3method(cmd)	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"
		end

		def set_owned_file_privileges(final_deployer_group)
			# ENTER HIDDEN DIRECTORY .GIT. Then need to recursively enter .git's NON-HIDDEN directories
				# Pass the name of the file to 'File.owned?' Will return true if the effective user ID of the
					# process is the same as the owner of the named file. This is a way of ensuring that the
					# user has the privileges to change the name of the file, and will change all of Their files.
					# Importantly, will change any NEWLY CREATED FILES that may need changing.
			Dir.glob('.git/**/*') do |f|
				change_priv_if_owned(f, final_deployer_group)
			end				
			# DOES NOT ENTER HIDDEN DIRECTORITES
			Dir.glob('**/*') do |f|
				change_priv_if_owned(f, final_deployer_group)
			end
		end

		def change_priv_if_owned(f, deployergroup)
			if File.owned?(f)
				cmd = "chown :#{deployergroup} #{f}"
				r= open3method(cmd)	
				puts "stdout_str: #{r[:stdout]}"
			    puts "stderr_str: #{r[:stderr]}"
			    puts "status: #{r[:status]}"
			    puts "status.exitstatus: #{r[:exit]}"

				cmd = "chmod 775 #{f}"
				r= open3method(cmd)	
				puts "stdout_str: #{r[:stdout]}"
			    puts "stderr_str: #{r[:stderr]}"
			    puts "status: #{r[:status]}"
			    puts "status.exitstatus: #{r[:exit]}"
			end
		end

		def fetch_branch_from_origin(git_branch)
			cmd = "git fetch -v origin #{git_branch}:refs/remotes/origin/#{git_branch}"
			open3method(cmd, 'out')		
		end

		def run_fetch_branch_from_origin
			# git_branch = v.get_git_branch(ev.machine_name)
			# out = g.fetch_branch_from_origin(git_branch)

			git_branch = 'dev'
			out = fetch_branch_from_origin(git_branch)
		
			puts "stdout: #{out[:stdout]}"
			puts "stderr: #{out[:stderr]}"
			puts "status: #{out[:status]}"
			puts "exit: #{out[:exit]}"
			if out[:stderr].include? "up to date"
				exit 1
			else
				$stdout.puts Rainbow("Success: fetch branch from origin").green
			end
			
		end

#rspec_tests
# fail_with_invalid_command
# clobber_assets
# stash_local_changes
# fetch_branch_from_origin('dev')
# merge_fetched_branch('dev', 'message from test')
# migrate_db
# generate_sql_script
# set_owned_file_privileges('railsdep')
run_fetch_branch_from_origin


