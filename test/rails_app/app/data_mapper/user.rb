require 'shared_user'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :facebook_token, String
  property :confirmation_token, String, :writer => :private
  timestamps :at

  class << self
    # attr_accessible is used by SharedUser. Instead of trying to make a
    # a compatibility method, ignore it and set writer option to private on
    # confirmation_token property.
    def attr_accessible(*args); nil; end
  end

  include SharedUser
  include Shim

  if VALIDATION_LIB == 'dm-validations'
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
end

# Define UserWithValidation here (instead of waiting for definition in
# devise/test/models_test.rb) to ensure it is finalized. Otherwise,
# DatabaseAuthenticatableTest 'should run validations even when current password is invalid or blank' fails.
class UserWithValidation < User
  validates_presence_of :username
end
