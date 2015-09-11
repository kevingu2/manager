class TasksController < ApplicationController
  #status, 0 is done, 1 is doing, 2 is to do, 3 is assigned by an manager but not accepted
  skip_before_action :verify_authenticity_token, only: [:updateStatus, :deleteOpportunity]
  before_action :set_oppties
  def index
  end

  def updateStatus
    json_body=JSON.parse(request.body.read)
    id= json_body.fetch('id')
    status=json_body.fetch('status')
    puts "id: "+id.to_s
    puts "status: "+status.to_s
    if id.nil? or status.nil? or UserOppty.where(id:id).empty?
      respond_to do |format|
        format.json { render json: "ERROR"}
      end
      return
    end
    userOppty=UserOppty.find(id)
    userOppty.update(status: status)
    respond_to do |format|
        format.json { render json: "OK"}
    end
  end
  
  def deleteOpportunity
    userOpptyId=params[:id]
    if userOpptyId.nil? || UserOppty.where(id: userOpptyId).empty?
      respond_to do |format|
        format.json { render json: "ERROR"}
      end
    else
      userOppty=UserOppty.find(userOpptyId)
      userOppty.delete
      respond_to do |format|
        format.json { render json: "OK"}
      end
    end
  end

  protected
  def set_oppties
    @done=UserOppty.where(user_id:session[:user_id]).where(status:DONE).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:DOING).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:TODO).joins(:oppty).includes(:oppty)
    @assigned=UserOppty.where(user_id:session[:user_id]).where(status:ASSIGNED).joins(:oppty).includes(:oppty)
  end
end
