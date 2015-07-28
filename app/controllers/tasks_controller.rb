class TasksController < ApplicationController
  #status, 0 is done, 1 is doing, 2 is to do, 3 is assigned by an manager but not accepted
  skip_before_action :verify_authenticity_token
  def index
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    @assigned=UserOppty.where(user_id:session[:user_id]).where(status:3).joins(:oppty).includes(:oppty)
  end

  def updateStatus
    userOppty=UserOppty.find(params[:id])
    userOppty.update(status: params[:status])
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    @assigned=UserOppty.where(user_id:session[:user_id]).where(status:3).joins(:oppty).includes(:oppty)
    respond_to do |format|
        format.html { render :index }
        format.json { render json: "msg:OK"}
    end
  end
  
  def deleteOpportunity
    userOppty=UserOppty.find(params[:id])
    userOppty.delete
    redirect_to tasks_index_path
  end
end
