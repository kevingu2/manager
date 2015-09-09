require 'test_helper'

class UserOpptyTest < ActiveSupport::TestCase

  test "User Oppty default status" do
    up=UserOppty.new
    assert up.valid?
    assert_equal TODO, up.status
  end
end
