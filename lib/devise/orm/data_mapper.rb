require 'dm-devise'
require 'devise/orm/data_mapper/compatibility'
require 'devise/orm/data_mapper/schema'
require 'devise/orm/data_mapper/date_time'
require 'devise/orm/data_mapper/dm-validations'

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
    end
  end
end

DataMapper::Model.append_extensions(Devise::Models)
DataMapper::Model.append_extensions(Devise::Orm::DataMapper::Hook)
