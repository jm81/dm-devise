require 'devise'
require 'dm-core'
require 'dm-serializer'
require 'dm-timestamps'
require 'dm-rails'

require 'dm-devise/version'

module Devise
  # Messages to use as the default DataMapper validation error messages. The
  # messages are updated from those included in dm-validations to be consistent
  # with ActiveModel (i.e. with the Devise test expectations) and include
  # additional messages that devise uses (:not_found, :already_confirmed,
  # :not_locked, and :expired). If set to false, the messages are left as
  # defined by the dm-validations gem.
  mattr_accessor :data_mapper_validation_messages
  @@data_mapper_validation_messages = {
    :absent => '%s must be absent',
    :inclusion => '%s is not included in the list',
    :exclusion => '%s is reserved',
    :invalid => '%s is invalid',
    :confirmation => "%s doesn't match confirmation",
    :confirmation_period_expired => '%s needs to be confirmed within %s, please request a new one',
    :accepted => '%s must be accepted',
    :nil => '%s must not be nil',
    :empty => "%s can't be empty",
    :blank => "%s can't be blank",
    :length_between => '%s must be between %s and %s characters long',
    :too_long => '%s is too long (maximum is %s characters)',
    :too_short => '%s is too short (minimum is %s characters)',
    :wrong_length => '%s "is the wrong length (should be %s characters)"',
    :taken => '%s has already been taken',
    :not_a_number => '%s is not a number',
    :not_an_integer => '%s must be an integer',
    :greater_than => '%s must be greater than %s',
    :greater_than_or_equal_to => '%s must be greater than or equal to %s',
    :equal_to => '%s must be equal to %s',
    :not_equal_to => '%s must not be equal to %s',
    :less_than => '%s must be less than %s',
    :less_than_or_equal_to => '%s must be less than or equal to %s',
    :value_between => '%s must be between %s and %s',
    :odd => 'must be odd',
    :even => 'must be even',
    :primitive => '%s must be of type %s',
    :not_found => '%s not found',
    :already_confirmed => '%s was already confirmed, please try signing in',
    :not_locked => '%s was not locked',
    :expired => '%s has expired, please request a new one'
  }

  class << self
    # Determine which validation library to use based on which validation
    # library is loaded. May be set explicitly to one of:
    #
    # - 'dm-validations'
    # - 'active_model'
    # - Any other value (false) to not load any validation compatibility code.
    mattr_writer :data_mapper_validation_lib
    @@data_mapper_validation_lib = nil
    def data_mapper_validation_lib
      if !@@data_mapper_validation_lib.nil?
        @@data_mapper_validation_lib.to_s
      elsif defined? DataMapper::Validations
        'dm-validations'
      elsif defined? ActiveModel::Validations
        'active_model'
      end
    end
  end
end
