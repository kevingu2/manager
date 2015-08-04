class InvalidDataController < ApplicationController
  def index
    @invalid_data=Oppty.where(["opptyName LIKE ? and rfpDate<?", "%#{params[:search]}%", Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)
  end

  def search
  	@invalid_data=Oppty.where(["opptyName LIKE ? and rfpDate<?", "%#{params[:search]}%", Date.today.to_s]).order(params[:sort]).page(params[:page]).per_page(15)
  end
end
