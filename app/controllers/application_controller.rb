#authorization needed before each action


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize
  protect_from_forgery with: :exception
  CRM_PATH = File.join(Rails.root, "public", "uploads")
  helper_method :deleteUnUnploadedFile
  
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
  def deleteUnUnploadedFile
    earliest_file_name=""
    earliest_date=Time.new
    if Dir[CRM_PATH + '/*.xlsm'].length > 1 #if there is more than one file, delete the old one. else the new overwrote the old, don't delete
      Dir[CRM_PATH + '/*.xlsm'].each do |item|
        next if item == '.' or item == '..'
        puts "*"*30
        puts item
        puts "*"*30
        puts "creation Time: "+File.ctime(item).to_s
        puts "Earliest_time: "+earliest_date.to_s
        if (File.ctime(item)<earliest_date)
          earliest_file_name=item
          earliest_date=File.ctime(item)
        end
      end
      puts "*"*30
      puts earliest_file_name
      puts earliest_date
      puts "*"*30
      FileUtils.mv(earliest_file_name,   File.join(Rails.root, "public", File.basename(earliest_file_name)))
      FileUtils.rm_rf(Dir.glob(CRM_PATH+'/*'))
      FileUtils.mv(File.join(Rails.root, "public", File.basename(earliest_file_name)),earliest_file_name)
    end
  end
end
