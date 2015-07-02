class UserOpptiesController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_user_oppty, only: [:show, :edit, :update, :destroy]

  # GET /user_oppties
  # GET /user_oppties.json
  def index
    @user_oppties = UserOppty.all
  end

  # GET /user_oppties/1
  # GET /user_oppties/1.json
  def show
  end

  # GET /user_oppties/new
  def new
    @user_oppty = UserOppty.new
  end

  # GET /user_oppties/1/edit
  def edit
  end

  # POST /user_oppties
  # POST /user_oppties.json
  def create
    oppty=Oppty.find(params[:oppty_id])
    @user_oppty=@user.add_oppty(oppty.id)
    respond_to do |format|
      if @user_oppty.save
        format.html { redirect_to @user_oppty, notice: 'User oppty was successfully created.' }
        format.json { render :show, status: :created, location: @user_oppty }
      else
        format.html { render :new }
        format.json { render json: @user_oppty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_oppties/1
  # PATCH/PUT /user_oppties/1.json
  def update
    respond_to do |format|
      if @user_oppty.update(user_oppty_params)
        format.html { redirect_to @user_oppty, notice: 'User oppty was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_oppty }
      else
        format.html { render :edit }
        format.json { render json: @user_oppty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_oppties/1
  # DELETE /user_oppties/1.json
  def destroy
    @user_oppty.destroy
    respond_to do |format|
      format.html { redirect_to user_oppties_url, notice: 'User oppty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_oppty
      @user_oppty = UserOppty.find(params[:id])
    end

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
