module Deploysuite
	class ProdDeployer
		include CommonDeployer

		def clone_app_db_functions(args)
			r.run_load_schema
			r.run_db_structure_dump
			r.run_db_rollback_all_migrations
			r.run_generate_sql_script
		end

		def update_app_db_functions(args)
			r.run_generate_sql_script
		end
	end
end