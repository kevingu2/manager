class AllocatedTasksController < ApplicationController
	def index
    	@oppties = Oppty.all.paginate(:per_page => 10, :page => params[:page])
    	@done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    	@doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    	@to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
  	end

end
