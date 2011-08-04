module Devise
  module Orm
    module DataMapper
      module ActiveModelCompatibility
        # include ActiveModel::Validations does not make save check valid?.
        # This may not be the best solution, but it seems to work. Note that
        # Compatibility is included after this module; its #save method handles
        # the :validate => false option.
        def save(*args)
          retval = valid? && super(*args)
          assert_save_successful(:save, retval)
          retval
        end
      end

      module ActiveModelUniquenessCompatibility
        def validates_uniqueness_of(*fields)
          validates_with UniquenessValidator, _merge_attributes(fields)
        end
      end

      class UniquenessValidator < ActiveModel::EachValidator
        def validate_each(target, attribute, value)
          resource = ::DataMapper.repository(target.repository.name) { target.model.first(attribute => value) }
          if resource.nil? || (target.saved? && resource.key == target.key)
            return true
          else
            target.errors.add(attribute, :taken)
            return false
          end
        end
      end
    end
  end
end
