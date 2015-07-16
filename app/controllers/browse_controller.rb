#accessing all opportunities and saving it in oppties variable for use in html
require 'action_view'

include ActionView::Helpers::DateHelper

class BrowseController < ApplicationController
  def index
    #get all Oppty objects from database into the @oppties collection
    @oppties = Oppty.order(params[:sort]).paginate(:per_page => 20, :page => params[:page])
    
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    

    @oppties.each do |o|
    	unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
    		@none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
   		end
    end
    
    @original = browse_index_path

    @within30days = []
    @within60days = []
    @within90days = []

    @current = Time.new
    @currentDay = @current.day
    @currentMonth = @current.month
    @currentYear = @current.year
    @beginDate = Date.new(@currentYear, @currentMonth, @currentDay)

    @oppties.each do |o|

      @pDate = o.proposalDueDate
      @pDateDay = @pDate.day 
      @pDateMonth = @pDate.month 
      @pDateYear = @pDate.year 
      @endDate = Date.new(@pDateYear, @pDateMonth, @pDateDay)
    
      @dayDiff = @endDate - @beginDate 
      @dayDiff = @dayDiff.to_i

      if @dayDiff >= 0
        if @dayDiff <= 30
          if o != nil then @within30days.push(o) end
        end
        if @dayDiff <= 60
          if o != nil then @within60days.push(o) end
        end
        if @dayDiff <= 90 
          if o != nil then @within90days.push(o) end
        end
      end
    end
  end

  def search
    @oppties = Oppty.where(["opptyName LIKE ?", "%#{params[:search]}%"]).paginate(:per_page => 20, :page => params[:page])

    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    

    @oppties.each do |o|
      unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
        @none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      end
    end

    @within30days = []
    @within60days = []
    @within90days = []

    @current = Time.new
    @currentDay = @current.day
    @currentMonth = @current.month
    @currentYear = @current.year
    @beginDate = Date.new(@currentYear, @currentMonth, @currentDay)

    @oppties.each do |o|

      @pDate = o.proposalDueDate
      @pDateDay = @pDate.day 
      @pDateMonth = @pDate.month 
      @pDateYear = @pDate.year 
      @endDate = Date.new(@pDateYear, @pDateMonth, @pDateDay)
    
      @dayDiff = @endDate - @beginDate 
      @dayDiff = @dayDiff.to_i

      if @dayDiff >= 0
        if @dayDiff <= 30
          if o != nil then @within30days.push(o) end
        end
        if @dayDiff <= 60
          if o != nil then @within60days.push(o) end
        end
        if @dayDiff <= 90 
          if o != nil then @within90days.push(o) end
        end
      end
    end
    
    
  end

end
