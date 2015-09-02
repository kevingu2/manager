require 'test_helper'

class OpptyTest < ActiveSupport::TestCase
  fixtures :oppties

  test "unique opptyId" do
    oppty=Oppty.new
    assert oppty.invalid?
    assert oppty.errors[:opptyId].any?
    oppty=Oppty.create(oppties(:one).attributes)
    assert_equal ["has already been taken"], oppty.errors[:opptyId]
  end
end
