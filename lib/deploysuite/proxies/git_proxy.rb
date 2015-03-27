
module Deploysuite
	class GitProxy 
		include CommandlineExecuter
		
		def clone_branch(git_branch, repo, host_path)						
		    cmd = "git clone -b #{git_branch} #{repo} #{host_path}"
		    open3method(cmd, 'out')		
		end

		def first_commit
			cmd = "git add ."
			open3method(cmd)

			cmd = "git commit -m 'First Commit'"
			open3method(cmd)				
		end

		def stash_local_changes
			cmd = "git stash"
			open3method(cmd, 'out')		
		end

		def fetch_branch_from_origin(git_branch)
			cmd = "git fetch -v origin #{git_branch}:refs/remotes/origin/#{git_branch}"
			open3method(cmd, 'out')		
		end

		def merge_fetched_branch(git_branch, message)
			cmd = "git merge origin/#{git_branch} -m '#{message}' "
			open3method(cmd, 'out')	
		end
	end
end