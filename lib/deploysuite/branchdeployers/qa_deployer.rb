module Deploysuite
	class QaDeployer
		include CommonDeployer
		
		def clone_app_db_functions(args)
			r.run_load_schema
			r.run_db_structure_dump
			r.run_make_temp_schema
			r.run_db_rollback_all_migrations			
			r.run_restore_old_schema
			r.run_copy_structure_sql(args[:host_path])
		end

		def update_app_db_functions(args)
			r.run_copy_sqlrake_file(args[:host_path], args[:ymlfiles_path])
			r.run_generate_sql_script
			r.run_remove_sqlrake_file(args[:host_path])
			r.run_copy_upgrade_sql(args[:host_path])
		end

	end
end