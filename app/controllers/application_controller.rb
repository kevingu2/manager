class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize
  protect_from_forgery with: :exception

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to sessions_new_path, notice: "Please log in"
    end
    writer=['tasks']
    manager=['allocated_tasks', 'invalid_data', 'upload_crm', 'statistics']
    if session[:role]=="writer"
      if manager.include? params[:controller]
        redirect_to invalid_entry_index_path, notice: "No Access"
      end
    end
    if session[:role]=="manager"
      if writer.include? params[:controller]
        redirect_to invalid_entry_index_path, notice: "No Access"
      end
    end

  end

end
