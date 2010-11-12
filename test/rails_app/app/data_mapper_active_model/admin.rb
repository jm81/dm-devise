require File.join(File.dirname(__FILE__), '../data_mapper/shim.rb')

class Admin
  include DataMapper::Resource

  property :id,   Serial
  property :username, String

  include Shim

  devise :database_authenticatable, :timeoutable, :registerable, :recoverable, :lockable, :unlock_strategy => :time
end
