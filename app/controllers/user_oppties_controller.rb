class UserOpptiesController < ApplicationController

  # POST /user_oppties
  # POST /user_oppties.json
  def create
    user_id=user_oppty_params['user_id']
    oppty_id=user_oppty_params['oppty_id']
    if user_id.nil? || User.where(id: user_id).empty? || Oppty.where(id: oppty_id).empty?
      redirect_to :back, notice: "Provide Correct Information"
      return
    end
    user=User.find(user_id)
    @user_oppty=user.add_oppty(user.id,oppty_id, TODO)
    if !@user_oppty
      redirect_to :back, notice: "Already Added Opportunity"
      return
    end
    respond_to do |format|
      if @user_oppty.save
        format.html { redirect_to tasks_index_path }
        format.json { render :show, status: :created, location: @user_oppty }
      else
        format.html { redirect_to :back, notice: "Error in Adding Opportunity"}
        format.json { render json: @user_oppty.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_oppty_params
    params.permit(:oppty_id, :user_id)
  end
end
