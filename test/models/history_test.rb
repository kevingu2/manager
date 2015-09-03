require 'test_helper'

class HistoryTest < ActiveSupport::TestCase
  fixtures :histories

  test "history is not valid with empty oppty Id" do
    history=History.new
    assert history.invalid?
    assert_equal [I18n.t('errors.messages.blank')], history.errors[:opptyId]
    history.opptyId="changed"
    history.valid?
  end
  test "history is not valid with same OpptyId" do
    history=History.create(oppties(:one).attributes)
    assert_equal [I18n.translate('errors.messages.taken')], history.errors[:opptyId]
    history.opptyId="changed"
    assert history.valid?
  end
end
