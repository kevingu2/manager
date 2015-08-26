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
    num_not=Notification.where(user_id: user_id, status:UNSEEN_NOTIFICATION)
    num_not.each do|n|
      n.update_attribute(:status, SEEN_NOTIFICATION)
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
      #iterate through all of the user's opportunities
      @notifications = Notification.where(user_id: session[:user_id])
      @num_unseen_notification= Notification.where(user_id: session[:user_id], status:UNSEEN_NOTIFICATION).size
      puts "User ID: "+@notifications.size.to_s
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
    puts "data length: "+Dir[CRM_PATH+ '/data'].length.to_s
  end
end
