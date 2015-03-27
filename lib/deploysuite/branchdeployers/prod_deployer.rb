module Deploysuite
	class ProdDeployer
		include CommonDeployer

		def clone_app_db_functions(args)
			puts "PENDING: NEED TO CHECK WITH MULTIPLE MIGRATIONS"
			# db:structure:dump ? WHAT IS THE STRUCTURE FILE and its purpose
				# Check if multiple migrations in original will translate into
				# the same number in the clone - i.e., PROBLEM if VERY MANY -brittle
				# OR if there is only one migration because 'db:shema:load' was used
			r.run_load_schema if args[:db]
			r.run_db_rollback_all_migrations if args[:db]
			r.run_generate_sql_script if[:db]
		end

		def update_app_db_functions(args)
			r.run_generate_sql_script
		end
	end
end