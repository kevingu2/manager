require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test "Notification relationship is not valid without a status" do
    notif=Notification.new
    assert notif.invalid?
    assert_equal [I18n.t('errors.messages.blank')], notif.errors[:status]
    notif.status=TODO
    assert notif.valid?
  end
end
