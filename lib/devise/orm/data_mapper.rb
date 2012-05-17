require 'dm-devise'
require 'devise/orm/data_mapper/compatibility'
require 'devise/orm/data_mapper/date_time'
require 'devise/orm/data_mapper/validations/dm-validations'
require 'devise/orm/data_mapper/validations/active_model'
require 'orm_adapter/adapters/data_mapper'

module Devise
  module Orm
    module DataMapper
      module Hook
        def devise_modules_hook!
          if Devise.data_mapper_validation_lib == 'active_model'
            include ActiveModel::Validations
            include ActiveModelCompatibility
            extend ActiveModelUniquenessCompatibility
          end

          include Compatibility

          yield
        end
      end
    end
  end
end

DataMapper::Model.append_extensions(Devise::Models)
DataMapper::Model.append_extensions(Devise::Orm::DataMapper::Hook)
