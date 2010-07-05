module Devise
  module Orm
    module DataMapper
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
            if :null == old_key
              # :required is opposite of :null
              options[new_key] = !options.delete(old_key)
            else
              options[new_key] = options.delete(old_key)
            end
          end

          options.delete(:default) if options[:default].nil?
          property name, type, options
        end
      end
    end
  end
end
