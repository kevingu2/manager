require 'test_helper'

class UserOpptyTest < ActiveSupport::TestCase
  test "User Oppty relationship is not valid without a status" do
    up=UserOppty.new
    assert up.invalid?
    assert_equal [I18n.t('errors.messages.blank')], up.errors[:status]
    up.status=TODO
    assert up.valid?
  end
end
