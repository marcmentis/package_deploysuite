# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','deploysuite','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'deploysuite'
  s.version = Deploysuite::VERSION
  s.author = 'Marc Mentis'
  s.email = 'mmentis@optonline.net'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command line suite wrapper around git, rake, rails to automate application deployment'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','deploysuite.rdoc']
  s.rdoc_options << '--title' << 'deploysuite' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'deploysuite'
  s.add_development_dependency('rake', '10.4.2')
  s.add_development_dependency('rdoc', '4.2.0')
  s.add_development_dependency('aruba', '0.6.2')
  s.add_development_dependency('rspec-mocks', '2.13.1')
  s.add_development_dependency('rspec-support', '3.2.1')
  s.add_development_dependency('rspec-core', '2.13.1')
  s.add_runtime_dependency('gli','2.12.2')
  s.add_runtime_dependency('rainbow')

  # ? need to add rspec to development_dependency 
    # rspec-mocks -v 2.13.1, rspec-support -v 3.2.1, rspec-core -v 2.13.1
end
