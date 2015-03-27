module Deploysuite
	class DevDeployer
		include CommonDeployer

		def clone_app_db_functions(args)
			r.run_load_schema
		end
		def update_app_db_functions(args)
			r.run_migrate_db
		end
		
	end
end