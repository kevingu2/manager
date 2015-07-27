class User < ActiveRecord::Base
  roles = [ 'writer', 'manager' ]
  validates :name, presence:true, uniqueness:true
  validates :role, presence:roles
  has_secure_password
  has_many :user_oppty, dependent: :destroy
  has_many :user_history, dependent: :destroy
  has_many :oppty, through: :user_oppty
  has_many :oppty, through: :user_history

  def add_oppty(user_id, oppty_id)
    uo=nil
    if !UserOppty.where(["user_id=? and oppty_id=?", user_id, oppty_id]).present?
      uo=user_oppty.build(oppty_id: oppty_id, status:2)
    end
    uo
  end

  def add_history(user_id, oppty_id)
    uh=nil
    oppty=Oppty.find_by(["id=?", oppty_id])
    if oppty.present?
      puts "Add to History"
      oppty_dict=oppty.attributes
      oppty_dict.delete('id')
      history=History.create(oppty_dict)
      if !UserHistory.where(["user_id=? and history_id=?", user_id, history.id]).present?
        uh=user_history.build(history_id: history.id)
      end
    end
    uh
  end
end
