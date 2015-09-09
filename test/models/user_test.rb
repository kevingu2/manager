require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test "user is not valid when name and role are not empty" do
    user=User.new
    assert user.invalid?
    assert_equal [I18n.t('errors.messages.blank')], user.errors[:name]
    assert_equal ["Incorrect Role"], user.errors[:role]
    user.name="test"
    user.role= "Writer"
    user.valid?
  end
  test "user must have a unique name" do
    user=User.create(users(:user1).attributes)
    assert_equal [I18n.translate('errors.messages.taken')], user.errors[:name]
    user.name="test"
    assert user.valid?
  end
  def new_user(role, name)
    User.new(name: name,
        password: "test",  role: role)
  end

  test "user is not valid when it does not have an valid role" do
    badRoles=["wrongRole1", "wrongRole2"]
    i=0
    ROLES.each do |r|
      assert new_user(r, i).valid?
      i+=1
    end
    badRoles.each do |r|
      i+=1
      assert new_user(r, i).invalid?
    end
  end

end
