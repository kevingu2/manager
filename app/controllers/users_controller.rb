class UsersController < ApplicationController
  before_action :set_user_id
  skip_before_action :authorize


  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sessions_new_path
    else
      redirect_to users_new_path, notice: "Error with Server."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :role)
    end

    # Reset the session that may be left by a previous user
    def set_user_id
      session[:user_id] = nil
    end
end
