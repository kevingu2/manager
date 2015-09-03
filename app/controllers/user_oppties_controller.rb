class UserOpptiesController < ApplicationController
  before_action :set_user, only: [:create]


  # POST /user_oppties
  # POST /user_oppties.json
  def create
    oppty=Oppty.find(params[:oppty_id])
    @user_oppty=@user.add_oppty(@user.id, oppty.id, 2)
    if !@user_oppty
      redirect_to :back, notice: "Already Added Opportunity"
      return
    end
      respond_to do |format|
        if @user_oppty.save
          format.html { redirect_to tasks_index_path }
          format.json { render :show, status: :created, location: @user_oppty }
        else
          format.html { render :new }
          format.json { render json: @user_oppty.errors, status: :unprocessable_entity }
        end
      end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_oppty_params
    params.require(:user_oppty).permit(:oppty_id, :user_id)
  end
  def set_user
    if session.has_key?(:user_id)
      @user = User.find(session[:user_id])
    end
  end
end
