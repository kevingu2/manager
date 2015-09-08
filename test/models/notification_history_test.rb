require 'test_helper'

class NotificationHistoryTest < ActiveSupport::TestCase
  test "Notification For History relationship is not valid without a status" do
    notif=NotificationHistory.new
    assert notif.invalid?
    assert_equal [I18n.t('errors.messages.blank')], notif.errors[:status]
    notif.status=TODO
    assert notif.valid?
  end
end
