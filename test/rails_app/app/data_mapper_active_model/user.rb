require 'shared_user'
require File.join(File.dirname(__FILE__), '../data_mapper/shim.rb')

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :facebook_token, String
  property :confirmation_token, String, :writer => :private
  timestamps :at

  include SharedUser
  include Shim
end
