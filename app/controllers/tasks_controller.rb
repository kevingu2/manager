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
    userOppty=UserOppty.find(id)
    if !userOppty.present?
      render :index
    end
    if !status.present?
      render :index
    end
    userOppty.update(status: status)
    respond_to do |format|
        format.html { render :index }
        format.json { render json: "OK"}
    end
  end
  
  def deleteOpportunity
    userOppty=UserOppty.find(params[:id])
    userOppty.delete
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    @assigned=UserOppty.where(user_id:session[:user_id]).where(status:3).joins(:oppty).includes(:oppty)
    respond_to do |format|
      format.json { render json: "OK"}
    end
  end
  
  def set_oppties
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    @assigned=UserOppty.where(user_id:session[:user_id]).where(status:3).joins(:oppty).includes(:oppty)
  end
end
