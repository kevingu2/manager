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
  end
end
