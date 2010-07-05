module Devise
  module Orm
    module DataMapper
      module Hook
        def devise_modules_hook!
          extend Schema
          include Compatibility
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end

      module Schema
        include Devise::Schema

        SCHEMA_OPTIONS = {
          :null  => :required,
          :limit => :length
        }

        # Tell how to apply schema methods. This automatically maps :limit to
        # :length and :null to :required.
        def apply_devise_schema(name, type, options={})
          SCHEMA_OPTIONS.each do |old_key, new_key|
            next unless options.key?(old_key)
            options[new_key] = options.delete(old_key)
          end

          options.delete(:default) if options[:default].nil?
          property name, type, options
        end
      end

      module Compatibility
        extend ActiveSupport::Concern

        module ClassMethods
          # Hooks for confirmable
          def before_create(*args)
            wrap_hook(:before, :create, *args)
          end

          def after_create(*args)
            wrap_hook(:after, :create, *args)
          end
          
          def before_save(*args)
            wrap_hook(:before, :save, *args)
          end

          def wrap_hook(action, method, *args)
            options = args.extract_options!

            args.each do |callback|
              callback_method = :"#{callback}_callback_wrap"
              send action, method, callback_method
              class_eval <<-METHOD, __FILE__, __LINE__ + 1
                def #{callback_method}
                  #{callback} if #{options[:if] || true}
                end
              METHOD
            end
          end

          # Add ActiveRecord like finder
          def find(*args)
            case args.first
            when :first, :all
              send(args.shift, *args)
            else
              get(*args)
            end
          end
        end

        def changed?
          dirty?
        end

        def save(options=nil)
          if options.is_a?(Hash) && options[:validate] == false
            save!
          else
            super()
          end
        end

        def update_attributes(*args)
          update(*args)
        end

        def invalid?
          !valid?
        end
      end
    end
  end
end

class DateTime
  unless method_defined?(:gmtime)
    delegate :gmtime, :to => :to_time
  end
end

DataMapper::Model.append_extensions(Devise::Models)
DataMapper::Model.append_extensions(Devise::Orm::DataMapper::Hook)

module DataMapper
  module Validate

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
        original_add(field_name, message)
      end
    end
  end
end

# Default error messages consistent with ActiveModel messages and devise
# expectations.
DataMapper::Validate::ValidationErrors.default_error_messages = {
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
  :already_confirmed => '%s was already confirmed',
  :not_locked => '%s was not locked'
}
