source 'https://rubygems.org'

gemspec

gem 'omniauth', '~> 1.0.0'
gem 'omniauth-oauth2', '~> 1.0.0'

group :test do
  gem 'omniauth-facebook'
  gem 'omniauth-openid', '~> 1.0.1'
  gem 'webrat', '0.7.2', :require => false
  gem 'mocha', :require => false
end

DM_VERSION = '~> 1.2.0'

group :development do
  gem 'rails', '~> 3.2.6'
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
