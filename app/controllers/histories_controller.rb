#handles one of the databases
#when the task is passed the due date, it'll move to the history database so
#users can view their previous tasks

class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create, :index]

  # GET /histories
  # GET /histories.json
  def index
    if params[:within] == "mine"
      @histories = UserHistory.where(user_id: @user.id).includes(:history).order(params[:sort]).page(params[:page]).per_page(15)
    else
      @histories=History.where("opptyName like ?", "%#{params[:search]}%").order(params[:sort]).page(params[:page]).per_page(15)
    end
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
    puts "Add to History"
    puts "*"*30
    UserOppty.where(oppty_id:oppty.id).each do|uo|
      puts "Add User "+uo.user_id.to_s
      user=User.find(uo.user_id)
      history=user.add_history(uo.user_id, oppty.id)
        if history.save
          puts "history saved: "+history.user_id.to_s
          #format.html { redirect_to histories_path, notice: 'History was successfully created.' }
          #format.json { render :show, status: :created, location: @history }
        else
          puts "history not saved"
          #format.html { render :new }
          #format.json { render json: @history.errors, status: :unprocessable_entity }
        end
    end
    puts "*"*30
    redirect_to histories_path, notice: 'History was successfully created.'
    deleteOppty(oppty.id)
  end
  def deleteOppty(oppty_id)
    puts "Delete Oppty: "+oppty_id.to_s
    oppty=Oppty.destroy(oppty_id)
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
