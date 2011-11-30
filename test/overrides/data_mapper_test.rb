require 'test_helper'

# This file contains test cases that override devise tests, in the cases that
# the difference is values from DM versus those expected by devise is not
# particularly important and getting DM to pass the original devise tests would
# be difficult.
#
# This file contains tests that are overriden regardless of validation library.
# Tests specific to dm-validations are in dm_validations_test.rb
# Tests specific to ActiveModel validations would be in active_model_test.rb,
# but there aren't any (I would be rather surprised if there ever were any).
#
# For each test, an explanation is given as to why I chose to override the test,
# and the original assertion is commented above the DM-specific assertion.

class TrackableHooksTest < ActionController::IntegrationTest

  undef test_current_and_last_sign_in_timestamps_are_updated_on_each_sign_in

  # DataMapper uses a DateTime type where ActiveRecord uses Time. The test is
  # that the tested properties are being set, so just check for kind_of?(DateTime)
  # instead of kind_of?(Time)
  test "current and last sign in timestamps are updated on each sign in" do
    user = create_user
    assert_nil user.current_sign_in_at
    assert_nil user.last_sign_in_at

    sign_in_as_user
    user.reload

    # assert_kind_of Time, user.current_sign_in_at
    # assert_kind_of Time, user.last_sign_in_at
    assert_kind_of DateTime, user.current_sign_in_at
    assert_kind_of DateTime, user.last_sign_in_at

    assert_equal user.current_sign_in_at, user.last_sign_in_at
    assert user.current_sign_in_at >= user.created_at

    visit destroy_user_session_path
    new_time = 2.seconds.from_now
    Time.stubs(:now).returns(new_time)

    sign_in_as_user
    user.reload
    assert user.current_sign_in_at > user.last_sign_in_at
  end
end

class DatabaseAuthenticatableTest < ActiveSupport::TestCase
  undef test_should_downcase_case_insensitive_keys_when_saving

  # save! is used in devise version of this test. In AR, save! runs callbacks
  # (and raises an error if any return false, which I assume is why its being
  # used). In DM, save! skips callbacks. Therefore, override and change #save!
  # to #save.
  test 'should downcase case insensitive keys when saving' do
    # case_insensitive_keys is set to :email by default.
    email = 'Foo@Bar.com'
    user = new_user(:email => email)

    assert_equal email, user.email
    user.save
    assert_equal email.downcase, user.email
  end

  undef test_should_remove_whitespace_from_strip_whitespace_keys_when_saving

  test 'should remove whitespace from strip whitespace keys when saving' do
    # strip_whitespace_keys is set to :email by default.
    email = ' foo@bar.com '
    user = new_user(:email => email)

    assert_equal email, user.email
    user.save
    assert_equal email.strip, user.email
  end

  # :as option is ActiveRecord-specific
  undef :"test_should_update_password_with_valid_current_password_and_:as_option"
  undef :"test_should_update_the_user_without_password_with_:as_option"
end

class ValidatableTest < ActiveSupport::TestCase
  # user.save! is failing in these tests, since validation are running anyway.
  # See https://github.com/datamapper/dm-validations/pull/13.

  undef :"test_should_require_uniqueness_of_email_if_email_has_changed,_allowing_blank"

  test 'should require uniqueness of email if email has changed, allowing blank' do
    existing_user = create_user

    user = new_user(:email => '')
    assert user.invalid?
    assert_no_match(/taken/, user.errors[:email].join)

    user.email = existing_user.email
    assert user.invalid?
    assert_match(/taken/, user.errors[:email].join)

    pending do
      user.save(:validate => false)
      assert user.valid?
    end
  end

  undef :"test_should_require_correct_email_format_if_email_has_changed,_allowing_blank"

  test 'should require correct email format if email has changed, allowing blank' do
    user = new_user(:email => '')
    assert user.invalid?
    assert_not_equal 'is invalid', user.errors[:email].join

    %w(invalid_email_format 123 $$$ \(\) ).each do |email|
      user.email = email
      assert user.invalid?, 'should be invalid with email ' << email
      assert_equal 'is invalid', user.errors[:email].join
    end

    pending do
      user.save(:validate => false)
      assert user.valid?
    end
  end
end

class SerializableTest < ActiveSupport::TestCase
  # AR's #to_xml replaces underscore with dash. DM does not.
  undef test_should_not_include_unsafe_keys_on_XML
  undef test_should_not_include_unsafe_keys_on_XML_even_if_a_new_except_is_provided
  undef test_should_include_unsafe_keys_on_XML_if_a_force_except_is_provided

  test 'should not include unsafe keys on XML' do
    assert_match /email/, @user.to_xml
    assert_no_match /confirmation_token/, @user.to_xml
  end

  test 'should not include unsafe keys on XML even if a new except is provided' do
    assert_no_match /email/, @user.to_xml(:except => :email)
    assert_no_match /confirmation_token/, @user.to_xml(:except => :email)
  end

  test 'should include unsafe keys on XML if a force_except is provided' do
    assert_no_match /email/, @user.to_xml(:force_except => :email)
    assert_match /confirmation_token/, @user.to_xml(:force_except => :email)
  end
end

class AuthenticationOthersTest < ActionController::IntegrationTest
  undef test_sign_in_stub_in_xml_format

  # In this test, password is nil. AR's serializer adds an attribute specifying
  # it is nil, while dm-serializer removes the property altogether.
  test 'sign in stub in xml format' do
    get new_user_session_path(:format => 'xml')
    assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<user>\n  <email></email>\n</user>\n", response.body
  end
end

class DeviseHelperTest < ActionController::IntegrationTest
  # Ensure test finds the translation of the model name.
  setup do
    I18n.backend.store_translations :fr,
    {
      :data_mapper => { :models => { :user => "utilisateur" } }
    }
  end
end
