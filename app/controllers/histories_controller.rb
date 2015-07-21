#handles one of the databases
#when the task is passed the due date, it'll move to the history database so
#users can view their previous tasks

class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create, :index]

  # GET /histories
  # GET /histories.json
  def index
    @all_histories=History.all
    @user_histories = UserHistory.where(user_id: @user.id).includes(:history).paginate(:per_page => 20, :page => params[:page])
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    oppty=Oppty.find(params[:oppty_id])
    @history=@user.add_history(@user.id, oppty.id)
    if !@history
      redirect_to invalid_entry_index_path, notice: "Already Added History"
      return
    end
    respond_to do |format|
      if @history.save
        format.html { redirect_to histories_path, notice: 'History was successfully created.' }
        format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:opptyName, :opptyId, :oppty_id, :user_id)
    end

    def set_user
      if session.has_key?(:user_id)
        @user = User.find(session[:user_id])
      end
    end
end
