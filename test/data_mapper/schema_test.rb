require 'test_helper'

class DataMapperSchemaTest < ActiveSupport::TestCase
  test 'required explicitly set to false' do
    begin
      DataMapper::Property.required(true)
      model = Class.new(User)
      model.apply_devise_schema :required_string, String, :required => true
      model.apply_devise_schema :not_required_string, String
      assert model.properties['required_string'].required?
      assert !model.properties['not_required_string'].required?
    ensure
      DataMapper::Property.required(false)
    end
  end
end
