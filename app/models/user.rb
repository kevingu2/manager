class User < ActiveRecord::Base
  roles = [ "writer", "manager" ]
  validates :name, presence:true, uniqueness:true
  validates :role, presence:roles
  has_secure_password
  has_many :user_oppty, dependent: :destroy
  has_many :history, dependent: :destroy
  def add_oppty(oppty_id)
    #TODO don't allow user to add mutliple oppty
    user_oppty.build(oppty_id: oppty_id, status:0)
    #puts "OPPTYYYYY"
    #if UserOppty.find(@user.id)
      #puts "ERROR IN ADDING OPPTUNITY"
      #raise "Opportunity has already been Added"
    #else
      #puts "ADDDEDDDDD"
      #user_oppty.build(oppty_id: oppty_id, status:0)
    #end
  end
end
