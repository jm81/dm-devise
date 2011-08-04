# encoding: UTF-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'dm-devise/version'

desc 'Default: run tests for all DataMapper ORM setups.'
task :default => :pre_commit

desc 'Run Devise tests for all DataMapper ORM setups.'
task :pre_commit do
  Dir[File.join(File.dirname(__FILE__), 'lib', 'devise', 'orm', 'data_mapper', 'validations', '*.rb')].each do |file|
    validation_lib = File.basename(file).split(".").first
    ENV['DEVISE_PATH'] ||= File.expand_path('../devise')
    system "rake test DEVISE_ORM=data_mapper VALIDATION_LIB=#{validation_lib} DEVISE_PATH=#{ENV['DEVISE_PATH']}"
  end
end

desc 'Run Devise tests using DataMapper. Specify path to devise with DEVISE_PATH'
Rake::TestTask.new(:test) do |test|
  ENV['DEVISE_ORM'] ||= 'data_mapper'
  ENV['VALIDATION_LIB'] ||= 'dm-validations'
  ENV['DEVISE_PATH'] ||= File.expand_path('../devise')
  unless File.exist?(ENV['DEVISE_PATH'])
    puts "Specify the path to devise (e.g. rake DEVISE_PATH=/path/to/devise). Not found at #{ENV['DEVISE_PATH']}"
    exit
  end
  test.libs << 'lib' << 'test'
  test.libs << "#{ENV['DEVISE_PATH']}/lib"
  test.libs << "#{ENV['DEVISE_PATH']}/test"
  test.test_files = FileList["#{ENV['DEVISE_PATH']}/test/**/*_test.rb"] + FileList['test/**/*_test.rb']
  test.verbose = true
end

desc 'Generate documentation for dm-devise.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'dm-devise #{version}'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
