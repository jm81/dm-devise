# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dm-devise/version"

Gem::Specification.new do |s|
  s.name        = "dm-devise"
  s.version     = DataMapper::Devise::VERSION.dup
  s.summary     = "DataMapper support for devise"
  s.description = "dm-devise adds DataMapper support to devise (http://github.com/plataformatec/devise) for authentication support for Rails"
  s.email       = "jmorgan@morgancreative.net"
  s.homepage    = "https://github.com/jm81/dm-devise"
  s.authors     = ["Jared Morgan"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('dm-core', '>= 1.0.2', '< 1.2')
  s.add_dependency('dm-migrations', '>= 1.0.2', '< 1.2')
  s.add_dependency('dm-serializer', '>= 1.0.2', '< 1.2')
  s.add_dependency('dm-timestamps', '>= 1.0.2', '< 1.2')
  s.add_dependency('dm-rails', '>= 1.0.3', '< 1.2')
  s.add_dependency('devise', '~> 1.3.0')
  s.add_dependency('sugar-high', '~> 0.2.10')
end
