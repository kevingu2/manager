#accessing all opportunities and saving it in oppties variable for use in html
require 'action_view'

include ActionView::Helpers::DateHelper

class BrowseController < ApplicationController
  def index
    #get all Oppty objects from database into the @oppties collection
    @oppties = Oppty.all
    
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    

    @oppties.each do |o|
    	unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
    		@none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
   		end
    end
    
    @original = browse_index_path







    # UserOppty must change to Oppty

    @today = Time.new
    @oppties.each do |o|
      @rfpDate = o.proposalDueDate
      puts @rfpDate
      @dayDiff = distance_of_time_in_words(@today, @rfpDate).to_i
      if @dayDiff <= 30
        @within30days=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      elsif @dayDiff <= 60
       @within60days=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      elsif @dayDiff <= 90 
        @within90days=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      end
    end
  end

  def search
    @oppties = Oppty.where(["opptyName LIKE ?", "%#{params[:search]}%"])

    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    

    @oppties.each do |o|
      unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
        @none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      end
    end





    # UserOppty must change to Oppty
    
    @today = Time.new
    @oppties.each do |o|
      @rfpDate = o.proposalDueDate
      @dayDiff = distance_of_time_in_words(@today, @rfpDate).to_i
      if @dayDiff <= 30 then @within30days=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      elsif @dayDiff <= 60 then @within60days=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      elsif @dayDiff <= 90 then @within90days=USerOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      end
    end
  end

end
