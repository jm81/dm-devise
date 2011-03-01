# Shim should be included after SharedUser / SharedAdmin
module Shim
  def self.included(klass)
    klass.extend(ModelMethods)
  end

  module ModelMethods
    # For benefit of Users::OmniauthCallbacksController
    def find_by_email(email)
      first(:email => email)
    end

    def create!(*args)
      create(*args)
    end

    def destroy_all
      all.destroy
    end
  end
end
