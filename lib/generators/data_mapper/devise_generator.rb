require 'generators/devise/orm_helpers'
require 'sugar-high/file'

module DataMapper
  module Generators
    class DeviseGenerator < Rails::Generators::NamedBase
      include ::Devise::Generators::OrmHelpers

      def generate_model
        invoke "data_mapper:model", [name] unless model_exists?
      end

      def inject_devise_content
        inject_into_file model_path, model_contents, :after => "include DataMapper::Resource\n"
      end

      def replace_default_devise_orm
        devise_init_file = File.join(Rails.root, 'config', 'initializers', 'devise.rb')
        File.replace_content_from devise_init_file, :where => 'orm/active_record', :with => 'orm/data_mapper'
      end
    end
  end
end
