#accessing all opportunities and saving it in oppties variable for use in html

class BrowseController < ApplicationController
  def index
    @oppties = Oppty.all
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    
    @oppties.each do |o|
    	unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
    		@none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
   		end
    end
  end
end
