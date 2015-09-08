class User < ActiveRecord::Base
  validates :name, presence:true, uniqueness:true
  validates_with RoleValidator
  has_secure_password
  has_many :user_oppty, dependent: :destroy
  has_many :user_history, dependent: :destroy
  has_many :notification_history, dependent: :destroy
  has_many :notification, dependent: :destroy
  has_many :oppty, through: :user_oppty
  has_many :oppty, through: :user_history
  has_many :oppty, through: :notification


  def add_oppty(user_id, oppty_id, status)
    uo=nil
    if !UserOppty.where(["user_id=? and oppty_id=?", user_id, oppty_id]).present?
      uo=user_oppty.build(oppty_id: oppty_id, status: status)
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

  #status, 0 is unseen, 1 is seen
  def add_notification(oppty_id, title, message, status)
    notification.build(oppty_id:oppty_id, title:title, message:message, status:status)
  end
  #status, 0 is unseen, 1 is seen
  def add_notification_history(history_id, title, message, status)
    notification_history.build(history_id:history_id, title:title, message:message, status:status)
  end


end

