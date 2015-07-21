#accessing all opportunities and saving it in oppties variable for use in html
require 'action_view'

include ActionView::Helpers::DateHelper

class BrowseController < ApplicationController
  def index
    #get all Oppty objects from database into the @oppties collection
    @oppties = Oppty.where("proposalDueDate >= ?", Date.today.to_s).order(params[:sort]).page(params[:page]).per_page(15)
    
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    
    
    @oppties.each do |o|
    	unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
    		@none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
   		end
    end


    thirty = Date.today()+30
    sixty = Date.today()+60
    ninety = Date.today()+90

    @within30days = Oppty.where("proposalDueDate >= ? and proposalDueDate <= ?", Date.today.to_s, thirty.to_s).page(params[:page]).per_page(15)
    @within60days = Oppty.where("proposalDueDate >= ? and proposalDueDate <= ?", Date.today.to_s, sixty.to_s).page(params[:page]).per_page(15)
    @within90days = Oppty.where("proposalDueDate >= ? and proposalDueDate <= ?", Date.today.to_s, ninety.to_s).page(params[:page]).per_page(15)


  end

  def search
    @oppties = Oppty.where(["opptyName LIKE ? and proposalDueDate >= ?", "%#{params[:search]}%",Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)

    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    

    @oppties.each do |o|
      unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
        @none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
      end
    end

    thirty = Date.today()+30
    sixty = Date.today()+60
    ninety = Date.today()+90

    @within30days = Oppty.where("proposalDueDate >= ? and proposalDueDate <= ?", Date.today.to_s, thirty.to_s).page(params[:page]).per_page(15)
    @within60days = Oppty.where("proposalDueDate >= ? and proposalDueDate <= ?", Date.today.to_s, sixty.to_s).page(params[:page]).per_page(15)
    @within90days = Oppty.where("proposalDueDate >= ? and proposalDueDate <= ?", Date.today.to_s, ninety.to_s).page(params[:page]).per_page(15)
    
  end

end
