#accessing all opportunities and saving it in oppties variable for use in html
require 'action_view'

include ActionView::Helpers::DateHelper

class BrowseController < ApplicationController
  def index

    if params[:within].to_i == 30 or params[:within].to_i == 60 or params[:within].to_i == 90
        endDate = Date.today()+params[:within].to_i
    else
        endDate = Date.today()+999999
    end

    #get all Oppty objects from database into the @oppties collection
    @oppties = Oppty.where(["opptyName LIKE ? and proposalDueDate >= ? and proposalDueDate <= ? and rfpDate >= ?", "%#{params[:search]}%", Date.today.to_s, endDate.to_s, Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)
    
    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    
    unless @oppties == nil
        @oppties.each do |o|
        	unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
        		@none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
       		end
        end
    end


  end

  def search
    
    if params[:within].to_i == 30 or params[:within].to_i == 60 or params[:within].to_i == 90
        endDate = Date.today()+params[:within].to_i
    else
        endDate = Date.today()+999999
    end

    @oppties = Oppty.where(["opptyName LIKE ? and proposalDueDate >= ? and proposalDueDate <= ? and rfpDate >= ?", "%#{params[:search]}%", Date.today.to_s, endDate.to_s, Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)

    @done=UserOppty.where(user_id:session[:user_id]).where(status:0).joins(:oppty).includes(:oppty)
    @doing=UserOppty.where(user_id:session[:user_id]).where(status:1).joins(:oppty).includes(:oppty)
    @to_do=UserOppty.where(user_id:session[:user_id]).where(status:2).joins(:oppty).includes(:oppty)
    
    unless @oppties == nil
        @oppties.each do |o|
          unless @done.include?(o) or @doing.include?(o) or @to_do.include?(o)
            @none=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
          end
        end
    end
 
  end

end
