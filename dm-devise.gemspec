# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-devise}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jared Morgan"]
  s.date = %q{2010-07-06}
  s.description = %q{dm-devise adds DataMapper support to devise (http://github.com/plataformatec/devise) for authentication support for Rails}
  s.email = %q{jmorgan@morgancreative.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "dm-devise.gemspec",
     "lib/devise/orm/data_mapper.rb",
     "lib/devise/orm/data_mapper/compatibility.rb",
     "lib/devise/orm/data_mapper/date_time.rb",
     "lib/devise/orm/data_mapper/dm-validations.rb",
     "lib/devise/orm/data_mapper/schema.rb",
     "lib/devise/orm/data_mapper_active_model.rb",
     "lib/dm-devise/version.rb",
     "lib/generators/data_mapper/devise_generator.rb",
     "test/orm/data_mapper.rb",
     "test/orm/data_mapper_active_model.rb",
     "test/overrides/data_mapper_test.rb",
     "test/overrides/dm_validations_test.rb",
     "test/rails_app/app/data_mapper/admin.rb",
     "test/rails_app/app/data_mapper/shim.rb",
     "test/rails_app/app/data_mapper/user.rb",
     "test/rails_app/app/data_mapper_active_model/admin.rb",
     "test/rails_app/app/data_mapper_active_model/shim.rb",
     "test/rails_app/app/data_mapper_active_model/user.rb",
     "test/rails_app/config/application.rb",
     "test/rails_app/config/environment.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/jm81/dm-devise}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Support for using DataMapper ORM with devise}
  s.test_files = [
    "test/test_helper.rb",
     "test/rails_app/config/environment.rb",
     "test/rails_app/config/application.rb",
     "test/rails_app/app/data_mapper/admin.rb",
     "test/rails_app/app/data_mapper/shim.rb",
     "test/rails_app/app/data_mapper/user.rb",
     "test/rails_app/app/data_mapper_active_model/admin.rb",
     "test/rails_app/app/data_mapper_active_model/shim.rb",
     "test/rails_app/app/data_mapper_active_model/user.rb",
     "test/overrides/data_mapper_test.rb",
     "test/overrides/dm_validations_test.rb",
     "test/orm/data_mapper.rb",
     "test/orm/data_mapper_active_model.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<dm-migrations>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<dm-validations>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<dm-serializer>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<dm-timestamps>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<dm-rails>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<warden>, ["~> 0.10.7"])
      s.add_runtime_dependency(%q<bcrypt-ruby>, ["~> 2.1.2"])
    else
      s.add_dependency(%q<dm-core>, ["~> 1.0.0"])
      s.add_dependency(%q<dm-migrations>, ["~> 1.0.0"])
      s.add_dependency(%q<dm-validations>, ["~> 1.0.0"])
      s.add_dependency(%q<dm-serializer>, ["~> 1.0.0"])
      s.add_dependency(%q<dm-timestamps>, ["~> 1.0.0"])
      s.add_dependency(%q<dm-rails>, ["~> 1.0.0"])
      s.add_dependency(%q<warden>, ["~> 0.10.7"])
      s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1.2"])
    end
  else
    s.add_dependency(%q<dm-core>, ["~> 1.0.0"])
    s.add_dependency(%q<dm-migrations>, ["~> 1.0.0"])
    s.add_dependency(%q<dm-validations>, ["~> 1.0.0"])
    s.add_dependency(%q<dm-serializer>, ["~> 1.0.0"])
    s.add_dependency(%q<dm-timestamps>, ["~> 1.0.0"])
    s.add_dependency(%q<dm-rails>, ["~> 1.0.0"])
    s.add_dependency(%q<warden>, ["~> 0.10.7"])
    s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1.2"])
  end
end

