module Deploysuite
	class ProdDeployer
		include CommonDeployer

		def clone_app_db_functions(args)
			r.run_load_schema
			r.run_db_structure_dump
			r.run_make_temp_schema
			r.run_db_rollback_all_migrations			
			r.run_restore_old_schema
		end

		def update_app_db_functions(args)
			r.run_copy_sqlrake_file(args[:host_path], args[:path_to_files_config])
			r.run_generate_sql_script
			r.run_remove_sqlrake_file(args[:host_path])
		end
	end
end