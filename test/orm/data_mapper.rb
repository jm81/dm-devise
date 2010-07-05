require 'rails/test_help'

DataMapper.auto_migrate!

class ActiveSupport::TestCase
  setup do
    User.all.destroy!
    Admin.all.destroy!
  end
end

module DataMapper
  module Validate
    class ValidationErrors

      # ActiveModel prepends field names in +#full_messages+, and so the
      # expected result of calling errors[field_name] will not include the
      # field name in the message. However, DM expects the field name to be
      # included in the original message. Assuming that the field name will
      # begin the message, just strip it out (plus the following space) for
      # testing purposes. This has no effect on #full_messages.
      def [](property_name)
        if property_errors = errors[property_name.to_sym]
          property_errors.collect do |message|
            message[(property_name.to_s.length + 1)..-1]
          end
        end
      end
    end
  end
end
