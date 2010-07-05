require 'test_helper'

# This file contains test cases that override devise tests, in the cases that
# the difference is values from DM versus those expected by devise is not
# particularly important and getting DM to pass the original devise tests would
# be difficult.
#
# For each test, an explanation is given as to why I chose to override the test,
# and the original assertion is commented above the DM-specific assertion.

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

class AuthenticationWithScopesTest < ActionController::IntegrationTest

  undef test_registration_in_xml_format

  # DM's validates_confirmation_of requires the confirmation field to be present,
  # while ActiveModel by default skips the confirmation test if the confirmation
  # value is nil. This test takes advantage of AM's behavior, so just add the
  # :password_confirmation value.
  test 'registration in xml format' do
    assert_nothing_raised do
      # post user_registration_path(:format => 'xml', :user => {:email => "test@example.com", :password => "invalid"} )
      post user_registration_path(:format => 'xml', :user => {:email => "test@example.com", :password => "invalid", :password_confirmation => "invalid"} )
    end
  end
end
