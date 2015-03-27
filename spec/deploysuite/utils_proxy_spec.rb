require 'spec_helper'

module Deploysuite
	describe UtilsProxy do
		it "move secret file to app/config folder" do
			u = UtilsProxy.new
			`touch /tmp/testfile.txt`
			`mkdir /tmp/config`
			file = "/tmp/testfile.txt"
			host_path = "/tmp"
			result = u.move_secret_file(file, host_path)
			`rm -Rf /tmp/config`
			expect(result).to include("Success")
		end

		it "change ownership of group for app folders/files" do
			u = UtilsProxy.new
			`mkdir /tmp/testapp`
			`touch /tmp/testapp/testfile.txt`
			host_path = "/tmp/testapp"
			final_deployer_group = "railsdep"

			u.set_app_group_ownership(host_path, final_deployer_group)

			file_group = `find /tmp/testapp -group railsdep`
			expect(file_group).to include("/tmp/testapp/testfile.txt")
			`rm -Rf /tmp/testapp`
		end

		it "change privileges for app folders/files" do
			u = UtilsProxy.new
			`mkdir /tmp/testapp`
			`touch /tmp/testapp/testfile.txt`
			host_path = "/tmp/testapp"

			u.set_app_permissions(host_path)

			file_privileges = `ls -l /tmp/testapp/testfile.txt`
			expect(file_privileges).to include("-rwxrwxr-x")
			`rm -Rf /tmp/testapp`
		end	
	end
end