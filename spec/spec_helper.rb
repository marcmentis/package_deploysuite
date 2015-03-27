require 'deploysuite'
require 'logger'
require 'socket'
require 'open3'

RSpec.configure do |config|
	original_stdout = $stdout
	config.before(:all) do
		#Redirect to /dev/null
		$stdout = File.open(File::NULL, "w")
	end
	config.after(:all) do
		$stdout = original_stdout
	end
end