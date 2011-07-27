source :rubygems

gemspec

gem 'oa-oauth', '~> 0.2.0', :require => 'omniauth/oauth'
gem 'oa-openid', '~> 0.2.0', :require => 'omniauth/openid'

group :test do
  gem 'webrat', '0.7.2', :require => false
  gem 'mocha', :require => false
end

DM_VERSION = '~> 1.1.0'

group :development do
  gem 'rails', '~> 3.0.4'
  gem 'dm-sqlite-adapter', DM_VERSION

  gem 'dm-core', DM_VERSION
  gem 'dm-migrations', DM_VERSION
  gem 'dm-serializer', DM_VERSION
  gem 'dm-timestamps', DM_VERSION
  gem 'dm-rails', DM_VERSION
end

group :data_mapper do
  gem 'dm-validations', DM_VERSION
end
