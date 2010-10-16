require 'shared_admin'
require File.join(File.dirname(__FILE__), '../data_mapper/shim.rb')

class Admin
  include DataMapper::Resource

  property :id,   Serial
  property :username, String

  include SharedAdmin
  include Shim

  property :remember_token, String
end
