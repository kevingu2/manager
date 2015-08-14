class AssignController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:assignUser, :unAssignUser]
  def index
    opptyId=params[:opptyId]
    puts opptyId
    @oppty=Oppty.find(opptyId)
    @assigned_writers=UserOppty.where(oppty_id: opptyId).joins('join (select * from users where role="writer")u
                                      on user_oppties.user_id=u.id').includes(:user)
    @not_assigned_writers=User.where(role: "writer").where('Not Exists(select * from user_oppties
                                      where oppty_id=? and users.id=user_id)', opptyId)
  end

  def assignUser
    json_body=JSON.parse(request.body.read)
    user_id= json_body.fetch('user_id')
    oppty_id=json_body.fetch('oppty_id')
    user=User.find(user_id)
    @user_oppty=user.add_oppty(params[:user_id], oppty_id, 3, false)
    if !@user_oppty
      redirect_to invalid_entry_index_path, notice: "User has been Assigned"
      return
    end
    respond_to do |format|
      if @user_oppty.save
        format.html { redirect_to @user_oppty, notice: 'Successfully Assigned User' }
        format.json { render :show, status: :created, location: @user_oppty }
      else
        format.html { render :new }
        format.json { render json: @user_oppty.errors, status: :unprocessable_entity }
      end
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
