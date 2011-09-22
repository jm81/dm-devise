source :rubygems

gemspec

gem 'oa-oauth', '~> 0.2.0', :require => 'omniauth/oauth'
gem 'oa-openid', '~> 0.2.0', :require => 'omniauth/openid'

group :test do
  gem 'webrat', '0.7.2', :require => false
  gem 'mocha', :require => false
end

DM_VERSION = '~> 1.2.0.rc2'

group :development do
  gem 'rails', '~> 3.1.0'
  gem 'dm-sqlite-adapter', DM_VERSION

  gem 'dm-core', DM_VERSION
  gem 'dm-migrations', DM_VERSION
  gem 'dm-serializer', DM_VERSION
  gem 'dm-timestamps', DM_VERSION
  gem 'dm-rails', DM_VERSION
end

group :'dm-validations' do
  gem 'dm-validations', DM_VERSION
end
