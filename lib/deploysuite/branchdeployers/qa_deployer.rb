module Deploysuite
	class QaDeployer
		include CommonDeployer
		
		def clone_app_db_functions(args)
			r.run_db_structure_dump
		end

		def update_app_db_functions(args)
			r.run_generate_sql_script
		end

		
	end
end