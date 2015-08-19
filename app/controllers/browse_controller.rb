#accessing all opportunities and saving it in oppties variable for use in html
require 'action_view'

include ActionView::Helpers::DateHelper

class BrowseController < ApplicationController
  def index

    if params[:within].to_i == 30 or params[:within].to_i == 60 or params[:within].to_i == 90
      endDate = Date.today()+params[:within].to_i
      beginDate = Date.today()
    else
      endDate = Date.today()+999999
      beginDate = Date.today-999999
    end

    if params[:invalid] == "rfpDate"
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ? and rfpDate < ? and (status2 == ? or status2 == ? or status2 == ?)", "%#{params[:search]}%", beginDate, endDate.to_s, Date.today().to_s, "P1-ID/Track", "P2-Qualification", "P3-Pursuit").order(params[:sort]).page(params[:page]).per_page(15)
    elsif params[:invalid] == "leadEstim"
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ? and (leadEstim == ? or leadEstim == ?)", "%#{params[:search]}%", beginDate, endDate.to_s, "TBD", "").order(params[:sort]).page(params[:page]).per_page(15)
    elsif params[:invalid] == "technicalLead"
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ? and (technicalLead == ? or technicalLead == ?)", "%#{params[:search]}%", beginDate, endDate.to_s, "TBD", "").order(params[:sort]).page(params[:page]).per_page(15)
    elsif params[:invalid] == "slDir"
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ? and (slDir == ? or slDir == ?)", "%#{params[:search]}%", beginDate, endDate.to_s, "TBD", "").order(params[:sort]).page(params[:page]).per_page(15)
    elsif params[:invalid] == "slArch"
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ? and (slArch == ? or slArch == ?)", "%#{params[:search]}%", beginDate, endDate.to_s, "TBD", "").order(params[:sort]).page(params[:page]).per_page(15)
    elsif params[:invalid] == "sllOrg"
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ? and
                             ((sllOrg == ? and (tss_va == ? or tss_va == ?)) or 
                              (sllOrg == ? and (swi_va == ? or swi_va == ?)) or 
                              (sllOrg == ? and (itms_va == ? or itms_va == ?)) or 
                              (sllOrg == ? and (mss_va == ? or mss_va == ?)) or 
                              (sllOrg == ? and (hwi_va == ? or hwi_va == ?)) or 
                              (sllOrg == ? and (ccds_va == ? or ccds_va == ?)) or 
                              (sllOrg == ? and (lsc_va == ? or lsc_va == ?)) or 
                              (sllOrg == ? and (nwi_va == ? or nwi_va == ?)) or 
                              (sllOrg == ? and (sss_va == ? or sss_va == ?)) )", 
                              "%#{params[:search]}%", beginDate, endDate.to_s,
                              "TSS", 0.0, "",
                              "SWI", 0.0, "",
                              "ITMS", 0.0, "",
                              "MSS", 0.0, "",
                              "HWI", 0.0, "",
                              "CCDS", 0.0, "",
                              "LSC", 0.0, "",
                              "NWI", 0.0, "",
                              "SSS", 0.0, "").order(params[:sort]).page(params[:page]).per_page(15)
    else 
      @oppties = Oppty.where("opptyName like ? and proposalDueDate >= ? and proposalDueDate <= ?", "%#{params[:search]}%", beginDate, endDate.to_s).order(params[:sort]).page(params[:page]).per_page(15)
    end

  end

end