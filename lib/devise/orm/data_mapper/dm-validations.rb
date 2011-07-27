module DataMapper
  module Validations

    # Monkey-patch ValidationErrors to support generation of error message from
    # a Symbol. This does not translate, consistent with normal DataMapper
    # operation. Set DataMapper::Validate::ValidationErrors.default_error_messages
    # if alternate messages are needed (after devise has been initialized).
    class ValidationErrors
      alias_method :original_add, :add

      # If the message is a Symbol, allow +default_error_message+ to generate
      # the message, including translation.
      def add(field_name, message)
        if message.kind_of?(Symbol)
          message = self.class.default_error_message(message, field_name)
        end
        original_add(field_name, message) unless errors[field_name].include?(message)
      end

      # Some devise controller actions expect resource#errors to respond to
      # #to_xml. Otherwise, we get a Missing template error
      def to_xml(options = {})
        @errors.to_hash.to_xml(options.merge(:root => 'errors'))
      end
    end
  end
end

# Default error messages consistent with ActiveModel messages and devise
# expectations.
DataMapper::Validations::ValidationErrors.default_error_messages = {
  :absent => '%s must be absent',
  :inclusion => '%s is not included in the list',
  :exclusion => '%s is reserved',
  :invalid => '%s is invalid',
  :confirmation => "%s doesn't match confirmation",
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
