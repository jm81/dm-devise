require 'shared_user'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :facebook_token, String
  timestamps :at

  include SharedUser
  include Shim

  before :valid?, :update_password_confirmation

  # DM's validates_confirmation_of requires the confirmation field to be present,
  # while ActiveModel by default skips the confirmation test if the confirmation
  # value is nil. This test takes advantage of AM's behavior, so just add the
  # :password_confirmation value.
  def update_password_confirmation
    if self.password && self.password_confirmation.nil?
      self.password_confirmation = self.password
    end
  end 
end
