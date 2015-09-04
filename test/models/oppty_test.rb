require 'test_helper'

class OpptyTest < ActiveSupport::TestCase
  fixtures :oppties

  test "oppty is not valid with empty oppty Id" do
    oppty=Oppty.new
    assert oppty.invalid?
    assert_equal [I18n.t('errors.messages.blank')], oppty.errors[:opptyId]
    oppty.opptyId="changed"
    oppty.valid?
  end
  test "oppty is not valid with same OpptyId" do
    oppty=Oppty.create(oppties(:oppty1).attributes)
    assert_equal [I18n.translate('errors.messages.taken')], oppty.errors[:opptyId]
    oppty.opptyId="changed"
    assert oppty.valid?
  end
end
