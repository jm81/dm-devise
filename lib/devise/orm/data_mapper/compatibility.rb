module Devise
  module Orm
    module DataMapper
      module Compatibility
        extend ActiveSupport::Concern

        module ClassMethods
          # Hooks for confirmable
          [:before, :after].each do |action|
            [:create, :update, :save].each do |method|
              define_method(:"#{action}_#{method}") do |*args|
                wrap_hook(action, method, *args)
              end
            end
          end

          def before_validation(*args)
            wrap_hook(:before, :valid?, *args)
          end

          def wrap_hook(action, method, *args)
            options = args.extract_options!

            args.each do |callback|
              callback_method = "#{action}_#{method}_#{callback}_callback_wrap".gsub('?', '').to_sym
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

        def email_was
          original_attributes[:email]
        end
      end
    end
  end
end
