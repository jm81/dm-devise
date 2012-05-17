module DataMapper
  module Generators
    class DeviseInstallGenerator < ::Rails::Generators::Base
      def generate_devise_install
        invoke 'devise:install'
      end

      def inject_data_mapper_content
        devise_init_file = File.join(::Rails.root, 'config', 'initializers', 'devise.rb')
        validations = <<VALIDATIONS
  # ==> Validations Library
  # dm-devise adds some compatibility methods for either dm-validations or
  # Active Model validations. By default, it determines what to load based on
  # which library is found (giving preference to dm-validations). You may
  # explicitly set this to 'dm-validations' or 'active_model', or false to not
  # load any of the validations compatibility code.
  # config.data_mapper_validation_lib = nil

VALIDATIONS
        inject_into_file devise_init_file, validations, :before => '  # ==> ORM configuration'

        data_mapper_options = <<OPTIONS

  # ==> dm-validations Default Error Messages
  # Messages to use as the default DataMapper validation error messages. The
  # messages are updated from those included in dm-validations to be consistent
  # with ActiveModel (i.e. with the Devise test expectations) and include
  # additional messages that devise uses (:not_found, :already_confirmed,
  # :not_locked, and :expired). If set to false, the messages are left as
  # defined by the dm-validations gem. See dm-devise.rb for default.
  # config.data_mapper_validation_messages = {}
OPTIONS
      inject_into_file devise_init_file, data_mapper_options, :after => "orm/data_mapper'\n"
      end
    end
  end
end
