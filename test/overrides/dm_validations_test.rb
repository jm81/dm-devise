require 'test_helper'

# See data_mapper_test.rb in this folder for what this file is doing.
if VALIDATION_LIB == 'dm-validations'
  class ValidatableTest < ActiveSupport::TestCase
    undef test_should_require_a_password_with_minimum_of_6_characters

    # DataMapper uses a :value_between error message when given a minimum and
    # maximum; ActiveModel shows either the :too_long or :too_short message.
    test 'should require a password with minimum of 6 characters' do
      user = new_user(:password => '12345', :password_confirmation => '12345')
      assert user.invalid?
      # assert_equal 'is too short (minimum is 6 characters)', user.errors[:password].join
      assert_equal 'must be between 6 and 128 characters long', user.errors[:password].join
    end

    undef test_should_require_a_password_with_maximum_of_128_characters_long

    # Same issue as previous test
    test 'should require a password with maximum of 128 characters long' do
      user = new_user(:password => 'x'*129, :password_confirmation => 'x'*129)
      assert user.invalid?
      # assert_equal 'is too long (maximum is 20 characters)', user.errors[:password].join
      assert_equal 'must be between 6 and 128 characters long', user.errors[:password].join
    end

    undef test_should_complain_about_length_even_if_possword_is_not_required

    test 'should complain about length even if possword is not required' do
      user = new_user(:password => 'x'*129, :password_confirmation => 'x'*129)
      user.stubs(:password_required?).returns(false)
      assert user.invalid?
      assert_equal 'must be between 6 and 128 characters long', user.errors[:password].join
    end
  end

  class ActiveRecordTest < ActiveSupport::TestCase
    undef test_validations_options_are_not_applied_too_late

    test 'validations options are not applied too late' do
      validators = WithValidation.validators.contexts[:default].select{|validator| validator.field_name == :password}
      length = validators.find { |v| v.class.name == 'DataMapper::Validations::LengthValidator' }
      assert_equal (2..6), length.options[:within]
    end

    undef test_validations_are_applied_just_once

    test 'validations are applied just once' do
      validators = Several.validators.contexts[:default].select{|validator| validator.field_name == :password}
      assert_equal 1, validators.select{ |v| v.kind_of?(DataMapper::Validations::LengthValidator) }.length
    end
  end
end
