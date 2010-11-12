require File.join(File.dirname(__FILE__), '../data_mapper/shim.rb')

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :facebook_token, String
  timestamps :at

  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
         :registerable, :rememberable, :timeoutable, :token_authenticatable,
         :trackable, :validatable

  include Shim
end
