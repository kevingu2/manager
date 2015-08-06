class InvalidDataController < ApplicationController
 def index
     if params[:search]
       @invalid_data=Oppty.where(["opptyName LIKE ? and rfpDate<?", "%#{params[:search]}%", Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)
     else
         @invalid_data=Oppty.where(["rfpDate<?", Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)
     end

 end

end