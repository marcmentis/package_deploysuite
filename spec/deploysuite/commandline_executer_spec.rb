require 'spec_helper'
include CommandlineExecuter


describe "CommandlineExecuter module has method:" do
	
	it "'open3method' which sucessfully runs valid'ls' command" do
		
		cmd = 'ls'
		r = open3method(cmd)
		expect(r[:exit]).to eq(0)
	end

end
