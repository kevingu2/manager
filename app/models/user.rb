class User < ActiveRecord::Base
  roles = [ 'writer', 'manager' ]
  validates :name, presence:true, uniqueness:true
  validates :role, presence:roles
  has_secure_password
  has_many :user_oppty, dependent: :destroy
  has_many :user_history, dependent: :destroy
  has_many :oppty, through: :user_oppty
  has_many :oppty, through: :user_history

  def add_oppty(user_id, oppty_id, status, changeRFP)
    uo=nil
    if !UserOppty.where(["user_id=? and oppty_id=?", user_id, oppty_id]).present?
      uo=user_oppty.build(oppty_id: oppty_id, status: status, changeRFP:changeRFP)
    end
    uo
  end

  def add_history(user_id, oppty_id, history_id)
    uh=nil
    oppty=Oppty.find_by(["id=?", oppty_id])
    if oppty.present?
      if !UserHistory.where(["user_id=? and history_id=?", user_id, history_id]).present?
        uh=user_history.build(history_id: history_id)
      end
    end
    uh
  end

  def remove_oppty(user_id, oppty_id)
    uo=nil
    uo=UserOppty.where(["user_id=? and oppty_id=?", user_id, oppty_id])
    if uo.present?
      user_oppty.destroy(uo)
    end
    uo
  end
end
