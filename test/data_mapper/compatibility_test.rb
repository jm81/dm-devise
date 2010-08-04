require 'test_helper'

class DataMapperCompatibilityTest < ActiveSupport::TestCase
  def teardown
    User.raise_on_save_failure = false
  end
  
  test 'respects raise_on_save_failure' do
    User.raise_on_save_failure = true
    user = new_user(:email => nil)
    assert user.invalid?
    assert_raise DataMapper::SaveFailureError do
      user.save
    end

    user = new_user
    assert user.valid?
    assert user.save

    User.raise_on_save_failure = false
    user = new_user(:email => nil)
    assert !user.save
  end
end
