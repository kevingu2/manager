class SessionsController < ApplicationController
  skip_before_action :authorize , only: [:destroy,:new, :create]
  def new
    session[:user_id] = nil
  end

  def create
    user = User.find_by(name: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:remember_me]=params[:remember_me]
      session[:username]=user.name
      session[:role]=user.role
      if user.role=="writer"
        redirect_to tasks_index_path
      end
      if user.role=="manager"
        redirect_to allocated_tasks_index_path
      end
    else
      redirect_to sessions_new_path, notice: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username]=nil
    session[:role]=nil
    session[:remember_me]=nil
    redirect_to sessions_new_path, notice: "Logged out"
  end
end
