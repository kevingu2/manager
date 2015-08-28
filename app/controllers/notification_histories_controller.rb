class NotificationHistoriesController < ApplicationController
  before_action :set_notification_history, only: [:show, :edit, :update, :destroy]

  # GET /notification_histories
  # GET /notification_histories.json
  def index
    @notification_histories = NotificationHistory.all
  end

  # GET /notification_histories/1
  # GET /notification_histories/1.json
  def show
  end

  # GET /notification_histories/new
  def new
    @notification_history = NotificationHistory.new
  end

  # GET /notification_histories/1/edit
  def edit
  end

  # POST /notification_histories
  # POST /notification_histories.json
  def create
    @notification_history = NotificationHistory.new(notification_history_params)

    respond_to do |format|
      if @notification_history.save
        format.html { redirect_to @notification_history, notice: 'Notification history was successfully created.' }
        format.json { render :show, status: :created, location: @notification_history }
      else
        format.html { render :new }
        format.json { render json: @notification_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notification_histories/1
  # PATCH/PUT /notification_histories/1.json
  def update
    respond_to do |format|
      if @notification_history.update(notification_history_params)
        format.html { redirect_to @notification_history, notice: 'Notification history was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification_history }
      else
        format.html { render :edit }
        format.json { render json: @notification_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_histories/1
  # DELETE /notification_histories/1.json
  def destroy
    @notification_history.destroy
    respond_to do |format|
      format.html { redirect_to notification_histories_url, notice: 'Notification history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_history
      @notification_history = NotificationHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_history_params
      params[:notification_history]
    end
end
