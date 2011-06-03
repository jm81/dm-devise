module Devise
  module Orm
    module DataMapper
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

          def before_validation(*args)
            wrap_hook(:before, :valid?, *args)
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

        def update_attribute(name, value)
          update(name => value)
        end

        def update_attributes(*args)
          update(*args)
        end

        def invalid?
          !valid?
        end

        def email_changed?
          attribute_dirty?(:email)
        end
      end
    end
  end
end
