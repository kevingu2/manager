require 'test_helper'

class UserOpptyTest < ActiveSupport::TestCase

  test "User Oppty default status" do
    uo=UserOppty.new
    assert uo.invalid?
    assert_equal [I18n.t('errors.messages.blank')], uo.errors[:status]
    uo.status=TODO
    assert uo.valid?
  end
end
