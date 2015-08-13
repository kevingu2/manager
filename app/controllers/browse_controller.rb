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

   if params[:search]
       @oppties = Oppty.where("opptyName like ? and proposalDueDate <= ?", "%#{params[:search]}%", endDate.to_s).order(params[:sort]).page(params[:page]).per_page(15)
   else 
       @oppties = Oppty.where("proposalDueDate <= ?", endDate.to_s).order(params[:sort]).page(params[:page]).per_page(15)
   end

 end

end