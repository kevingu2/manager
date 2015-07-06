class User < ActiveRecord::Base
  roles = [ 'writer', 'manager' ]
  validates :name, presence:true, uniqueness:true
  validates :role, presence:roles
  has_secure_password
  has_many :user_oppty, dependent: :destroy
  has_many :history, dependent: :destroy

  def add_oppty(user_id, oppty_id)
    user=nil
    if !UserOppty.where(["user_id=? and oppty_id=?", user_id, oppty_id]).present?
      user=user_oppty.build(oppty_id: oppty_id, status:2)
    end
    user
  end
  def add_history(user_id, oppty_id)
    user=nil
    if !History.where(["user_id=? and oppty_id=?", user_id, oppty_id]).present?
      user=history.build(oppty_id: oppty_id)
    end
    user
  end
end
