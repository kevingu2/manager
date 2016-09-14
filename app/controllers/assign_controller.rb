class AssignController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:assignUser, :unAssignUser]
  def index
    opptyId=params[:opptyId]
    if opptyId.nil?
      redirect_to invalid_entry_index_path, 
	notice: "Opportunity does not Exist"
    else
      @oppty=Oppty.find(opptyId)
      @assigned_writers=getAssigned(WRITER_ROLE, nil, opptyId)
      @not_assigned_writers=getUnassigned(WRITER_ROLE, nil, opptyId)
    end
  end

  def searchNotAssigned
    not_assigned=getUnassigned(params[:role], params[:search], params[:opptyId])
    respond_to do |format|
      format.json { render json: not_assigned.to_json}
    end
  end

  def searchAssigned
    user_oppties=getAssigned(params[:role], params[:search], params[:opptyId])
    assigned=[]
    user_oppties.each do |uo|
      assigned.push(uo.user);
    end
    respond_to do |format|
      format.json { render json: assigned.to_json}
    end
  end

  def getAssigned(role, keyword,opptyId)
    if keyword.present?
      return UserOppty.where(oppty_id: opptyId).joins('join (select * from users where role=\''+role+'\' and name LIKE"'+"%#{keyword}%"+'")u
                                      on user_oppties.user_id=u.id').includes(:user)
    else
      return UserOppty.where(oppty_id: opptyId).joins('join (select * from users where role=\''+role+'\')u
                                      on user_oppties.user_id=u.id').includes(:user)
    end
  end
  def getUnassigned(role, keyword, opptyId)
    if keyword.present?
      return User.where("role == ? and name LIKE ?", '\''+role+'\'', "%#{keyword}%").where('Not Exists(select * from user_oppties
                                         where oppty_id=? and users.id=user_id)', opptyId)
    else
       return User.where(role: "Writer").where('Not Exists(select * from user_oppties
                                      where oppty_id=? and users.id=user_id)', opptyId)
    end
  end

  def assignUser
    json_body=JSON.parse(request.body.read)
    user_id= json_body.fetch('user_id')
    oppty_id=json_body.fetch('oppty_id')
    user=User.find(user_id)
    user_oppty=user.add_oppty(params[:user_id], oppty_id, 3)
    if !user_oppty
      redirect_to invalid_entry_index_path, notice: "User has been Assigned"
      return
    end
    respond_to do |format|
      if user_oppty.save
        format.html { redirect_to user_oppty, notice: 'Successfully Assigned User' }
        format.json { render :show, status: :created, location: @user_oppty }
      else
        format.html { render :new }
        format.json { render json: user_oppty.errors, status: :unprocessable_entity }
      end
    end
    #add a notification to the user
    oppty=Oppty.find(oppty_id)
    notification=user.add_notification(oppty_id ,ASSIGNEDTASK,oppty.opptyName+" has been been added to your assigned tasks",UNSEEN_NOTIFICATION);
    if notification.save
      puts "notification saved: "+notification.user_id.to_s
    else
      puts "notification not saved"
    end
  end

  def unAssignUser
    json_body=JSON.parse(request.body.read)
    user_id= json_body.fetch('user_id')
    oppty_id=json_body.fetch('oppty_id')
    user=User.find(user_id)
    respond_to do |format|
      if user.remove_oppty(user_id, oppty_id).present?
        format.json { render json: {msg:"OK"}}
      else
        format.json {  render json: {msg:"ERROR"}}
      end
    end
  end
end
