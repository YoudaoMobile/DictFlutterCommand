# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','dfb','version.rb'])
require File.join([File.dirname(__FILE__),'lib','path_manager.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'dfb'
  s.version = Dfb::VERSION
  s.author = 'chedechao'
  s.email = 'chedechao333@163.com'
  s.homepage = 'https://github.com/YoudaoMobile/DictFlutterCommand.git'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("
")
  s.require_paths = 'lib'
  s.extra_rdoc_files = ['README.rdoc','dfb.rdoc']
  s.rdoc_options << '--title' << 'dfb' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'dfb'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.19.0')
end
