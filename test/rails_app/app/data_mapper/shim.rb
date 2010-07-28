# Shim should be included after SharedUser / SharedAdmin
module Shim
  def self.included(klass)
    klass.extend(ModelMethods)
  end

  module ModelMethods
    # Override version in SharedUser which uses #find_by_email.
    def find_for_facebook_oauth(access_token, signed_in_resource=nil)
      data = ActiveSupport::JSON.decode(access_token.get('/me'))
      user = signed_in_resource || User.first(:email => data["email"]) || User.new
      user.update_with_facebook_oauth(access_token, data)
      user.save
      user
    end
    
    def create!(*args)
      create(*args)
    end

    def destroy_all
      all.destroy
    end
  end
end
