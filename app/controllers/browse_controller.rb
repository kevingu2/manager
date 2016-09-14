#accessing all opportunities and saving it in oppties variable for use in html
require 'action_view'

include ActionView::Helpers::DateHelper

class BrowseController < ApplicationController
  def index
    @allOppties = Oppty.all
    @allSlDir = Array.new
    @allOppties.each do |n|
      if n.slDir != ""
        unless @allSlDir.include?(n.slDir)
          @allSlDir.push(n.slDir)
        end
      end
    end
    @allSlDir.sort_by!{ |e| e.downcase }
    @oppties=searchOppty(params[:search], params[:within], params[:invalid], params[:sort], params[:filter]).page(params[:page]).per_page(15)
    print @oppties
    respond_to do |format|
      format.html { render :index}
      format.json { render json: @oppties}
    end
  end

  def getAllOppties
    oppties=searchOppty(params[:keyword], params[:day], params[:invalid], params[:opptyField], params[:slDir])
    respond_to do |format|
      format.json { render json: oppties}
    end
  end

  protected
  def searchOppty(keyword,day, invalid, opptyField, slDir)
    if day.to_i == 30 or day.to_i == 60 or day.to_i == 90
      endDate = Date.today()+day.to_i
      beginDate = Date.today()
    else
      endDate = Date.today()+999999
      beginDate = Date.today-999999
    end

    if slDir.to_s != "all"
      slDirName = slDir.to_s
    else
      slDirName = ""
    end

    if opptyField.to_s =="none"
      opptyField=""
    end

    if slDirName != ""
      if invalid == "rfpDate"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and rfpDate < ? and (status2 == ? or status2 == ? or status2 == ?) and slDir == ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, Date.today().to_s, "P1-ID/Track", "P2-Qualification", "P3-Pursuit", slDirName).order(opptyField)
      elsif invalid == "leadEstim"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (leadEstim == ? or leadEstim == ?) and slDir == ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "", slDirName).order(opptyField)
      elsif invalid == "technicalLead"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (technicalLead == ? or technicalLead == ?) and slDir == ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "", slDirName).order(opptyField)
      elsif invalid == "slDir"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (slDir == ? or slDir == ?) and slDir == ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "", slDirName).order(opptyField)
      elsif invalid == "slArch"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (slArch == ? or slArch == ?) and slDir == ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "", slDirName).order(opptyField)
      elsif invalid == "sllOrg"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and
                               ((sllOrg == ? and (tss_va == ? or tss_va == ?)) or
                                (sllOrg == ? and (swi_va == ? or swi_va == ?)) or
                                (sllOrg == ? and (itms_va == ? or itms_va == ?)) or
                                (sllOrg == ? and (mss_va == ? or mss_va == ?)) or
                                (sllOrg == ? and (hwi_va == ? or hwi_va == ?)) or
                                (sllOrg == ? and (ccds_va == ? or ccds_va == ?)) or
                                (sllOrg == ? and (lsc_va == ? or lsc_va == ?)) or
                                (sllOrg == ? and (nwi_va == ? or nwi_va == ?)) or
                                (sllOrg == ? and (sss_va == ? or sss_va == ?)) ) and slDir == ?",
                               "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s,
                               "TSS", 0.0, "",
                               "SWI", 0.0, "",
                               "ITMS", 0.0, "",
                               "MSS", 0.0, "",
                               "HWI", 0.0, "",
                               "CCDS", 0.0, "",
                               "LSC", 0.0, "",
                               "NWI", 0.0, "",
                               "SSS", 0.0, "", slDirName).order(opptyField)
      else
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and slDir == ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, slDirName).order(opptyField)
      end

    else
      if invalid == "rfpDate"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and rfpDate < ? and (status2 == ? or status2 == ? or status2 == ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, Date.today().to_s, "P1-ID/Track", "P2-Qualification", "P3-Pursuit").order(opptyField)
      elsif invalid == "leadEstim"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (leadEstim == ? or leadEstim == ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "").order(opptyField)
      elsif invalid == "technicalLead"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (technicalLead == ? or technicalLead == ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "").order(opptyField)
      elsif invalid == "slDir"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (slDir == ? or slDir == ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "").order(opptyField)
      elsif invalid == "slArch"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and (slArch == ? or slArch == ?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s, "TBD", "").order(opptyField)
      elsif invalid == "sllOrg"
        oppties = Oppty.where("(opptyName like ? or opptyId like ? or codeName like ? or cgOrg like ?) and proposalDueDate >= ? and proposalDueDate <= ? and
                               ((sllOrg == ? and (tss_va == ? or tss_va == ?)) or
                                (sllOrg == ? and (swi_va == ? or swi_va == ?)) or
                                (sllOrg == ? and (itms_va == ? or itms_va == ?)) or
                                (sllOrg == ? and (mss_va == ? or mss_va == ?)) or
                                (sllOrg == ? and (hwi_va == ? or hwi_va == ?)) or
                                (sllOrg == ? and (ccds_va == ? or ccds_va == ?)) or
                                (sllOrg == ? and (lsc_va == ? or lsc_va == ?)) or
                                (sllOrg == ? and (nwi_va == ? or nwi_va == ?)) or
                                (sllOrg == ? and (sss_va == ? or sss_va == ?)) )",
                               "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s,
                               "TSS", 0.0, "",
                               "SWI", 0.0, "",
                               "ITMS", 0.0, "",
                               "MSS", 0.0, "",
                               "HWI", 0.0, "",
                               "CCDS", 0.0, "",
                               "LSC", 0.0, "",
                               "NWI", 0.0, "",
                               "SSS", 0.0, "").order(opptyField)
      else
        oppties = Oppty.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and \"proposalDueDate\" >= ? and \"proposalDueDate\" <= ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", beginDate, endDate.to_s).order(opptyField)
      end
      return oppties
    end
  end
end
