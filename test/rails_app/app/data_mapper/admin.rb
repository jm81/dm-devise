class Admin
  include DataMapper::Resource

  property :id,   Serial
  property :username, String
  
  include Shim
  
  devise :database_authenticatable, :timeoutable, :registerable, :recoverable, :lockable, :unlock_strategy => :time
end
