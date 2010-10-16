require 'shared_admin'

class Admin
  include DataMapper::Resource

  property :id,   Serial
  property :username, String

  include SharedAdmin
  include Shim

  property :remember_token, String
end
