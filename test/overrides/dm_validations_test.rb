require 'test_helper'

# See data_mapper_test.rb in this folder for what this file is doing.
if DEVISE_ORM == :data_mapper

  class ValidatableTest < ActiveSupport::TestCase
    undef test_should_require_a_password_with_minimum_of_6_characters

    # DataMapper uses a :value_between error message when given a minimum and
    # maximum; ActiveModel shows either the :too_long or :too_short message.
    test 'should require a password with minimum of 6 characters' do
      user = new_user(:password => '12345', :password_confirmation => '12345')
      assert user.invalid?
      # assert_equal 'is too short (minimum is 6 characters)', user.errors[:password].join
      assert_equal 'must be between 6 and 20 characters long', user.errors[:password].join
    end

    undef test_should_require_a_password_with_maximum_of_20_characters_long

    # Same issue as previous test
    test 'should require a password with maximum of 20 characters long' do
      user = new_user(:password => 'x'*21, :password_confirmation => 'x'*21)
      assert user.invalid?
      # assert_equal 'is too long (maximum is 20 characters)', user.errors[:password].join
      assert_equal 'must be between 6 and 20 characters long', user.errors[:password].join
    end

  end

  class AuthenticationOthersTest < ActionController::IntegrationTest

    undef test_registration_in_xml_format_works_when_recognizing_path

    # DM's validates_confirmation_of requires the confirmation field to be present,
    # while ActiveModel by default skips the confirmation test if the confirmation
    # value is nil. This test takes advantage of AM's behavior, so just add the
    # :password_confirmation value.
    test 'registration in xml format works when recognizing path' do
      assert_nothing_raised do
        # post user_registration_path(:format => 'xml', :user => {:email => "test@example.com", :password => "invalid"} )
        post user_registration_path(:format => 'xml', :user => {:email => "test@example.com", :password => "invalid", :password_confirmation => "invalid"} )
      end
    end
  end

  class ActiveRecordTest < ActiveSupport::TestCase
    undef test_validations_options_are_not_applied_to_late

    test 'validations options are not applied to late' do
      validators = WithValidation.validators.contexts[:default].select{|validator| validator.field_name == :password}
      length = validators.find { |v| v.class.name == 'DataMapper::Validations::LengthValidator' }
      assert_equal (2..6), length.options[:within]
    end
  end
end
