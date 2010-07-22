class Admin
  include DataMapper::Resource  
  
  property :id,   Serial
  property :username, String
  
  devise :database_authenticatable, :registerable, :timeoutable, :recoverable, :lockable, :unlock_strategy => :time
  
  def self.create!(*args)
    create(*args)
  end
end
