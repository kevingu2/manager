class InvalidDataController < ApplicationController
	def index
		if params[:search]
		   @invalid_data=Oppty.where(["opptyName LIKE ? and rfpDate<? or leadEstim == ? or leadEstim == ? or technicalLead == ? or technicalLead == ? or slDir == ? or slDir == ? or slArch == ? or slArch == ?", 
		   "%#{params[:search]}%", Date.today.to_s, "TBD", "", "TBD", "", "TBD", "", "TBD", ""]).order(params[:sort]).page(params[:page]).per_page(15)
		else
		   @invalid_data=Oppty.where(["rfpDate<? or leadEstim == ? or leadEstim == ? or technicalLead == ? or technicalLead == ? or slDir == ? or slDir == ? or slArch == ? or slArch == ?",
		   Date.today.to_s, "TBD", "", "TBD", "", "TBD", "", "TBD", ""]).order(params[:sort]).page(params[:page]).per_page(15)
		end

	end

end
