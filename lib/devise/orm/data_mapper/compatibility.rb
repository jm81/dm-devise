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
            # valid? checking isn't added automatically with ActiveModel
            valid? && super()
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
