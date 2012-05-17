require 'generators/devise/orm_helpers'

module DataMapper
  module Generators
    class DeviseGenerator < ::Rails::Generators::NamedBase
      include ::Devise::Generators::OrmHelpers

      def generate_model
        invoke "data_mapper:model", [name] unless model_exists? && behavior == :invoke
      end

      def inject_property_types
        inject_into_file model_path, migration_data, :after => "include DataMapper::Resource\n" if model_exists?
      end

      def inject_devise_content
        inject_into_file model_path, model_contents, :after => "include DataMapper::Resource\n" if model_exists?
      end

      def migration_data
<<RUBY
  ## Database authenticatable
  property :email,              String, :required => true, :default => "", :length => 255
  property :encrypted_password, String, :required => true, :default => "", :length => 255

  ## Recoverable
  property :reset_password_token,   String
  property :reset_password_sent_at, DateTime

  ## Rememberable
  property :remember_created_at, DateTime

  ## Trackable
  property :sign_in_count,      Integer, :default => 0
  property :current_sign_in_at, DateTime
  property :last_sign_in_at,    DateTime
  property :current_sign_in_ip, String
  property :last_sign_in_ip,    String

  ## Encryptable
  # property :password_salt, String

  ## Confirmable
  # property :confirmation_token,   String
  # property :confirmed_at,         DateTime
  # property :confirmation_sent_at, DateTime
  # property :unconfirmed_email,    String # Only if using reconfirmable

  ## Lockable
  # property :failed_attempts, Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # property :unlock_token,    String # Only if unlock strategy is :email or :both
  # property :locked_at,       DateTime

  ## Token authenticatable
  # property :authentication_token, String, :length => 255

  ## Invitable
  # property :invitation_token, String, :length => 255
RUBY
      end
    end
  end
end
