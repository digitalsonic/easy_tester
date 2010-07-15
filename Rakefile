require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |s|
  s.name = 'easytester'
  s.version = '0.1.5'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'A simple test tool for WebService and Web.'
  s.description = "A simple test tool for WebService and Web (eg. HTTP gateway.do response). All you need is to write a short script and prepare the test case."
  s.author = 'DigitalSonic'
  s.email = 'digitalsonic.dxf@gmail.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
  s.add_dependency('jruby-openssl', '~> 0.7') if RUBY_PLATFORM =~ /java/
  s.add_dependency('soap4r', '~> 1.5')
  s.add_dependency('nokogiri', '~> 1.4')
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "EasyTester Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
  rdoc.options << '--charset' << 'utf-8'
end

Rake::TestTask.new do |t|
  lib_dir = File.expand_path('lib')
  test_dir = File.expand_path('test')
  t.libs = [lib_dir, test_dir]
  t.test_files = FileList['test/**/*_test.rb']
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.libs << Dir["lib"]
end