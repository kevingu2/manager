class SessionsController < ApplicationController
  skip_before_action :authorize , only: [:destroy,:new, :create]

  def new
    session[:user_id] = nil
  end

  def create
    user = User.find_by(name: params[:username])
    if user and user.authenticate(params[:password])
      puts "USER ROLE: "+user.role
      puts "USER ID: "+user.id.to_s
      session[:user_id] = user.id
      session[:remember_me]=params[:remember_me]
      session[:username]=user.name
      redirect_to tasks_index_path
    else
      redirect_to sessions_new_path, notice: "Invalid user/password combination" end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_path, notice: "Logged out"
  end
end
