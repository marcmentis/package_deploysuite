module Deploysuite
	class QaDeployer
		include CommonDeployer
		
		def clone_app_db_functions(args)
			r.run_load_schema
			r.run_db_structure_dump
			r.run_make_temp_schema
			r.run_db_rollback_all_migrations			
			r.run_restore_old_schema
			# r.run_generate_sql_script

			# Better method. Just give structure.sql AFTER 
				# creating db tables normally
			# r.run_load_schema
			# r.run_db_structure_dump
		end

		def update_app_db_functions(args)
			r.run_copy_sqlrake_file(args[:host_path], args[:path_to_files_config])
			r.run_generate_sql_script
			r.run_remove_sqlrake_file(args[:host_path])

			# Better method. Just give sql script after
				# crating db tables normally
			# r.run_generate_db_and_sql_script
		end

	end
end