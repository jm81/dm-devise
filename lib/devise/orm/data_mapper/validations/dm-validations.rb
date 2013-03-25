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
        def add(field_name, message = nil, active_record_options = {})
          if message.kind_of?(Symbol)
            message = get_message(field_name, message, active_record_options)
          end
          original_add(field_name, message) unless errors[field_name].include?(message)
        end

        # Some devise controller actions expect resource#errors to respond to
        # #to_xml. Otherwise, we get a Missing template error
        def to_xml(options = {})
          @errors.to_hash.to_xml(options.merge(:root => 'errors'))
        end

        private

        ##
        # verify if a message is already define in property and use is if possible
        #
        def get_message(field_name, message = nil, active_record_options = {})
          if resource.class.properties[:email].options[:messages]
            resource.class.properties[:email].options[:messages][message]
          else
            self.class.default_error_message(message, field_name, active_record_options.values)
          end
        end
      end
    end
  end

  if Devise.data_mapper_validation_messages
    DataMapper::Validations::ValidationErrors.default_error_messages = Devise.data_mapper_validation_messages
  end
end
