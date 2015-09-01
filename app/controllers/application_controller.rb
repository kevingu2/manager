#authorization needed before each action

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize, :setNotification, :deleteUnUploadedFile
  protect_from_forgery with: :exception
  helper_method :getUploadedFileName
  skip_before_action :verify_authenticity_token, only: [:resetNotification]
  CRM_PATH = File.join(Rails.root, "public", "uploads")

  def resetNotification
    json_body=JSON.parse(request.body.read)
    user_id= json_body.fetch('user_id')

    #make oppty notiifications update to status seen
    num_not=Notification.where(user_id: user_id, status:UNSEEN_NOTIFICATION)
    num_not.each do|n|
      n.update_attribute(:status, SEEN_NOTIFICATION)
    end

    #make history notiifications update to status seen
    num_not=NotificationHistory.where(user_id: user_id, status:UNSEEN_NOTIFICATION)
    num_not.each do|nh|
      nh.update_attribute(:status, SEEN_NOTIFICATION)
    end

    respond_to do |format|
      format.json { render json: {msg:"OK"}}
    end
  end

  #depending on user's role, they can access/update certain information
  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to sessions_new_path, notice: "Please log in"
    end
    writer=['tasks']
    manager=['allocated_tasks', 'invalid_data', 'upload_crm', 'statistics']
    if session[:role]=="Writer"
      if manager.include? params[:controller]
        redirect_to invalid_entry_index_path, notice: "No Access"
      end
    end
    if session[:role]=="Manager"
      if writer.include? params[:controller]
        redirect_to invalid_entry_index_path, notice: "No Access"
      end
    end
  end

  def setNotification
      #a hash to hold booleans for each oppty_id, with true corresponding to 'the id is inside oppties' 
      @notif_array = []
      #get all notifications
      @allNotifications = Notification.all
      #collect user's notifications for opportunities into a collection
      @notifications = Notification.where(user_id: session[:user_id])
      #used to hold notifications for moved opportunities
      @notifications_moved = {}
      #iterate through all of the notifications, moving notifications 
      @allNotifications.each do |notif|
        unless @notifications.includes(notif)
          @notifications_moved.push(notif) 
        end
      end

      #get all notifications for histories
      @allHistoryNotifications = NotificationHistory.all
      #collect user's notifications for histories into a collection
      @history_notifications = NotificationHistory.where(user_id: session[:user_id])
      #used to hold notifications for moved opportunities
      @history_notifications_moved = {}
      #iterate through all of the notifications, moving notifications 
      @allHistoryNotifications.each do |notif_hist|
        unless @history_notifications.includes(notif_hist)
          @history_notifications_moved.push(notif_hist) 
        end
      end

      #count the number of unseen notifications for opportunities for display in view
      @num_unseen_notification_oppty = Notification.where(user_id: session[:user_id], status:UNSEEN_NOTIFICATION).size
      #count the number of unseen notifications for histories for display in view
      @num_unseen_notification_history = NotificationHistory.where(user_id: session[:user_id], status:UNSEEN_NOTIFICATION).size
      #add up both counts
      @num_unseen_notification = @num_unseen_notification_oppty + @num_unseen_notification_history

      arrayCount = 0

      #fill up hash with opportunity notifications
      @notifications.each do |n|
          #check for this notification's oppty inside of opportunity database
          @notif_array[arrayCount] =  n #Oppty.find_by(id: n.oppty_id) 
          arrayCount += 1
      end

      #fill up hash with opportunity notifications
      @notifications_moved.each do |n|
          #check for this notification's oppty inside of opportunity database
          @notif_array[arrayCount] =  n #Oppty.find_by(id: n.oppty_id) 
          arrayCount += 1
      end

      #fill up hash with history notifications
      @history_notifications.each do |hn|
          #check for this notification's oppty inside of opportunity database
          @notif_array[arrayCount] = hn #History.find_by(id: hn.history_id) 
          arrayCount += 1
      end

      #fill up hash with history notifications
      @history_notifications_moved.each do |hn|
          #check for this notification's oppty inside of opportunity database
          @notif_array[arrayCount] = hn #History.find_by(id: hn.history_id) 
          arrayCount += 1
      end

      #sort array by the created_at field
      #notif_array.sort!(&:created_at)
  end

  def getUploadedFileName
    @download_path=""
    if Dir[CRM_PATH + '/*.xlsm'].length > 1 #if there is more than one file, delete the old one. else the new overwrote the old, don't delete
      earliest_file_name=""
      earliest_date=Time.new
      Dir[CRM_PATH + '/*.xlsm'].each do |item|
        next if item == '.' or item == '..'
        if (File.ctime(item)<earliest_date)
          earliest_file_name=item
          earliest_date=File.ctime(item)
        end
      end
      @download_path= earliest_file_name
    elsif Dir[CRM_PATH+'/*.xlsm'].length==1
           @download_path=File.join(Dir[CRM_PATH+'/*.xlsm'][0])
    end
    @uploaded_file_name=File.basename(@download_path).gsub("new_", "").gsub("%20", " ")
    return @download_path
  end

  def deleteUnUploadedFile
    download_path=getUploadedFileName
    if Dir[CRM_PATH + '/*.xlsm'].length > 1 #if there is more than one file, delete the old one. else the new overwrote the old, don't delete
      Dir[CRM_PATH + '/*.xlsm'].each do |item|
        if(item!=download_path)
          FileUtils.rm(item)
        end
      end
    elsif Dir[CRM_PATH+ '/data/*'].length==0
      Dir[CRM_PATH + '/*.xlsm'].each do |item|
        FileUtils.rm(item)
      end
    end
  end
end
