puts <<DEPRECATION
WARN: orm/data_mapper/data_mapper_active_model is deprecated. dm-devise now
checks for which validation library is available. To force dm-devise to use
ActiveModel::Validations, add the following above the ORM require line in your
devise initializer:

   config.data_mapper_validation_lib = 'active_model'
DEPRECATION

Devise.data_mapper_validation_lib = 'active_model'
require 'devise/orm/data_mapper'
