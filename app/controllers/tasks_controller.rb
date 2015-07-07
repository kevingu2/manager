#handles communication between model and view

#finds the user opportunity of the user, find the user opportunity's status
#finds the details of the user opportunity

class TasksController < ApplicationController
  #status, 0 is done, 1 is doing, 2 is to do
  def index
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
  end
  
  #status changes when writers move the tasks to "To Do" or "Done" columns
  def updateStatus
    userOppty=UserOppty.find(params[:id])
    userOppty.update(status: params[:status])
    redirect_to tasks_index_path
  end

  #deleting the opportunity by clicking on the red cross
  def deleteOpportunity
    userOppty=UserOppty.find(params[:id])
    userOppty.delete
    redirect_to tasks_index_path
  end
end
