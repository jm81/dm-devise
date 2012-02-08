if Devise.data_mapper_validation_lib == 'dm-validations'
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
        def add(field_name, message = nil)
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

  if Devise.data_mapper_validation_messages
    DataMapper::Validations::ValidationErrors.default_error_messages = Devise.data_mapper_validation_messages
  end
end
