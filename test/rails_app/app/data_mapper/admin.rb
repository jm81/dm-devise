require 'shared_admin'

class Admin
  include DataMapper::Resource

  property :id,   Serial

  ## Database authenticatable
  property :email,              String, :required => false
  property :encrypted_password, String, :required => false, :length => 255

  ## Recoverable
  property :reset_password_token,   String
  property :reset_password_sent_at, DateTime

  ## Rememberable
  property :remember_created_at, DateTime

  ## Confirmable
  property :confirmation_token,   String
  property :confirmed_at,         DateTime
  property :confirmation_sent_at, DateTime
  property :unconfirmed_email,    String # Only if using reconfirmable

  ## Encryptable
  property :password_salt, String

  ## Lockable
  property :locked_at, DateTime

  include SharedAdmin
  include Shim
end
