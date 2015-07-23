class CrmController < ApplicationController
  CRM_PATH = File.join(Rails.root, "public", "uploads")
  DOWNLOAD_PATH =""
  def index
    @uploaded=false
  end
  def checkDate
    uploaded_io = params[:upl]

    # get existing file in public/uploads
    @oldFileName=nil
    if Dir[CRM_PATH+'/*.xlsm'][0]
      @oldFileName=File.basename(Dir[CRM_PATH+'/*.xlsm'][0])
    end
    # get original file's date
    # check if older or newer
    File.open(Rails.root.join('public', 'uploads', "new_"+uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @newFileName = "new_"+uploaded_io.original_filename.to_s

    @oldOrNew = "old"
    if Dir[CRM_PATH+ '/*.xlsm'].length > 1
      @oldOrNew =  `python bin/dateExtract.py "public/uploads/#{@newFileName}" "public/uploads/#{@oldFileName}"`
    else
      @oldOrNew = "new"
    end
    render :index

  end
# after submit is pushed
  def updateCRM
    # oldFileName
    # newFileName
    puts "*"*30
    oldFileName=params[:old]
    newFileName=params[:new]
    changes=params[:changes]
    changes = JSON.parse(changes)
    puts oldFileName
    puts newFileName
    puts changes
    puts "*"*30
    if Dir[CRM_PATH+ '/*.xlsm'].length > 1
      `rm #{CRM_PATH}/#{oldFileName}`
    end
    opptyIds = [] # holds ids in the database
    Oppty.find_each do |o|
      opptyIds.push(o.opptyId)
    end
    data = `python bin/excelReader.py "public/uploads/#{newFileName}"`
    data = JSON.parse(data)
    uploadedIds = [] # holds uploaded ids
    data.each do |d|
      uploadedIds.push(d["OpptyID"])
    end
    ids = opptyIds - uploadedIds
    newIds = uploadedIds - opptyIds
    if changes.any?
      puts changes
      puts changes.length
      changes.each do |c|
        Oppty.find_by(opptyId:c).delete
        newIds.push(c)
      end
    end
    ids.each do |i|
      moveToHistory(i)
    end
    addNewOppty(data, newIds, uploadedIds)
    redirect_to crm_index_path
  end

  def addNewOppty(data, newIds, uploadedIds)
    data.each do |opportunity|
      if !newIds.include? opportunity["OpptyID"] then next end # if id not supposed to be added, skip
      if History.find_by(opptyId:opportunity["OpptyID"]) then next end
      uploadedIds.push(opportunity["OpptyID"])
      #if there is some magical ruby way to do this better, please do it. I don't know ruby :(
      #quite possibly the hackiest code in this project
      #######################get values from json##########################

      @oppty=Oppty.new
      #fields
      @oppty.opptyId               = opportunity["OpptyID"]
      @oppty.opptyName             = opportunity["OpptyName"]
      @oppty.idiqCA                = opportunity["IDIQ_CA"]
      @oppty.status2               = opportunity["Status2"]
      @oppty.value                 = opportunity["Total Value $M"]
      @oppty.pWin                  = opportunity["pWin"]
      @oppty.captureMgr            = opportunity["Capturemgr"]
      @oppty.programMgr            = opportunity["ProgramMgr"]
      @oppty.proposalMgr           = opportunity["ProposalMgr"]
      @oppty.technicalLead         = opportunity["TechnicalLead"]
      @oppty.slArch                = opportunity["SLArch"]
      @oppty.slComments            = opportunity["SL Comments"]
      @oppty.rfpDate               = Date.new(1899,12,30) + opportunity["RFPDate"].to_f
      @oppty.awardDate             = Date.new(1899,12,30) + opportunity["AwardDate"].to_f
      @oppty.slDir                 = opportunity["SLDir"]
      @oppty.leadEstim             = opportunity["LeadEstim"]
      @oppty.engaged               = opportunity["Engaged r/y/g"]
      @oppty.solution              = opportunity["Solution r/y/g"]
      @oppty.estimate              = opportunity["Estimate r/y/g"]
      @oppty.proposalDueDate       = Date.new(1899,12,30) + opportunity["ProposalDueDate"].to_f
      @oppty.codeName              = opportunity["CodeName"]
      @oppty.descriptionOfWork     = opportunity["DescriptionOfWork"]
      @oppty.category              = opportunity["Category"]
      @oppty.pwald                 = opportunity["PWALD"]
      @oppty.pBid                  = opportunity["pBid"]
      @oppty.awardFV               = opportunity["AwardFV"]
      @oppty.saicvaPercent         = opportunity["SAICVA%"]
      @oppty.saicva                = opportunity["SAIC VA $M"]
      @oppty.mat                   = opportunity["Mat%"]
      @oppty.materialsTV           = opportunity["Mat TV $M"]
      @oppty.subc                  = opportunity["Subc%"]
      @oppty.subTV                 = opportunity["Subc TV $M"]
      @oppty.cg_va                 = opportunity["CG_VA"]
      @oppty.sss_va                = opportunity["SSS-3621"] # i have no idea why
      @oppty.nwi_va                = opportunity["NWI-3933"]
      @oppty.hwi_va                = opportunity["HWI-3648"]
      @oppty.itms_va               = opportunity["ITMS-3896"]
      @oppty.tss_va                = opportunity["TSS-3676"]
      @oppty.ccds_va               = opportunity["CCDS-3932"]
      @oppty.mss_va                = opportunity["MSS-3690"]
      @oppty.swi_va                = opportunity["SWI-3934"]
      @oppty.lsc_va                = opportunity["LSC-3640"]
      @oppty.zzOth_va              = opportunity["zzOth_VA"]
      @oppty.pri                   = opportunity["Pri"]
      @oppty.aop                   = opportunity["AOP"]
      @oppty.peg                   = opportunity["PEG"]
      @oppty.mustWin               = opportunity["MustWin"]
      @oppty.feeIndic              = opportunity["FeeIndic"]
      @oppty.slutil                = opportunity["Slutil"]
      @oppty.recompete             = opportunity["Recompete"]
      @oppty.competitive           = opportunity["Competitive"]
      @oppty.international         = opportunity["International"]
      @oppty.strategic             = opportunity["Strategic"]
      @oppty.bundle                = opportunity["Bundle"]
      @oppty.bidReviewStream       = opportunity["BidReviewStream"]
      @oppty.definedDelivPgm       = opportunity["DefinedDelivPgm"]
      @oppty.evaluationCriteria    = opportunity["EvaluationCriteria"]
      @oppty.perfWorkLoc           = opportunity["PerfWorkLoc"]
      @oppty.classIfReqmt          = opportunity["ClassifReqmt"]
      @oppty.grouping              = opportunity["Grouping"]
      @oppty.reasonForWinLoss      = opportunity["ReasonforWinLoss"]
      @oppty.egr                   = opportunity["EGR"]
      @oppty.slCat                 = opportunity["SLcat"]
      @oppty.slPri                 = opportunity["Slpri"]
      @oppty.slNote                = opportunity["Slnote"]
      @oppty.crmRunDate            = opportunity["CRMRunDate"]
      @oppty.contractStartDate     = opportunity["ContractStartDate"]
      @oppty.rfpFYPer              = opportunity["RFPFYPer"]
      @oppty.submitFYPer           = opportunity["SubmitFYPer"]
      @oppty.awardFYPer            = opportunity["AwardFYPer"]
      @oppty.preBPprojID           = opportunity["PreBPprojID"]
      @oppty.fy16PreBP             = opportunity["FY16 PreB&P$"]
      @oppty.fy16PreBPSpent        = opportunity["FY16 PreB&P $Spent"]
      @oppty.fy16PreBPSpentPercent = opportunity["FY16 PreB&P %Spent"]
      @oppty.bpProjID              = opportunity["BPprojID"]
      @oppty.fy16BDTot             = opportunity["FY16 BDTot$"]
      @oppty.fy16BDTotSpent        = opportunity["FY16 BDTot $Spent"]
      @oppty.fy16BDTotSpentPercent = opportunity["FY16 BDTot %Spent"]
      @oppty.financeDate           = opportunity["FinDate"]
      @oppty.cgSecOrg              = opportunity["SecOrg"]
      @oppty.cgSecMgr              = opportunity["SecMgr"]
      @oppty.cgOrg                 = opportunity["CGOrg"]
      @oppty.cgMgr                 = opportunity["CGMgr"]
      @oppty.opOrg                 = opportunity["OpOrg"]
      @oppty.cgOpMgr               = opportunity["OpMgr"]
      @oppty.cgPgmDir              = opportunity["PgmDir"]
      @oppty.bdMgr                 = opportunity["BDMgr"]
      @oppty.crmRecOwner           = opportunity["CRMRecOwner"]
      @oppty.sslMgr                = opportunity["SSLeadMgr"]
      @oppty.divNum                = opportunity["DivNum"]
      @oppty.customer              = opportunity["Customer"]
      @oppty.endCustomer           = opportunity["EndCustomer"]
      @oppty.crn                   = opportunity["CRN"]
      @oppty.contractType          = opportunity["ContractType"]
      @oppty.opptyClass            = opportunity["OpptyClass"]
      @oppty.numberOfAwards        = opportunity["NumberOfAwards"]
      @oppty.totalPOP              = opportunity["TotalPOP"]
      @oppty.primeSub              = opportunity["PrimeSub"]
      @oppty.fy16BP                = opportunity["FY16 B&P$"]
      @oppty.fy16BPSpent           = opportunity["FY16 B&P $Spent"]
      @oppty.fy16BPSpentPercent    = opportunity["FY16 B&P %Spent"]
      @oppty.save
    end
  end

  def moveToHistory(oppty_id)
    oppty=Oppty.find_by(["opptyId=?", oppty_id])
    if oppty.present?
      puts "moving to history: " + oppty_id
      oppty_dict=oppty.attributes
      oppty_dict.delete('id')
      #puts oppty_dict
      history=History.create(oppty_dict)
      oppty.delete
      # if !UserHistory.where(["user_id=? and history_id=?", user_id, history.id]).present?
      #   user=user_history.build(history_id: history.id)
      # end
    else
      puts "oppty not present"
    end
  end

  def delete(fileName)
    if Dir[CRM_PATH + '/*.xlsm'].length > 1 #if there is more than one file, delete the old one. else the new overwrote the old, don't delete
      puts `mv #{fileName} ../#{CRM_PATH}`
      puts `rm -rf #{CRM_PATH}`
      puts `mv ../#{CRM_PATH}/#{fileName} #{CRM_PATH}`
    end
  end

  #uploading an excel file from user's computer
  def upload
    puts params[:newFileName]
    puts params[:oldFileName]
    @newFileName=params[:newFileName]
    @oldFileName=params[:oldFileName]
    data = `python bin/excelReader.py "public/uploads/#{@newFileName}"`
    data = JSON.parse(data)
    @changes = [] # holds list of hashes that contain what is changed
    @added = 0
    uploadedIds=[]
    opptyIds=[]
    change = false
    id = 0
    data.each do |opportunity| # for all the opportunities
      change = false
      id = opportunity["OpptyID"] # get the id
      uploadedIds.push(id)
      oppty = Oppty.find_by(opptyId:id)
      if oppty != nil && id == oppty.opptyId # check if the oppty is in the database
        # if the cell changed, hashtable contains the new value and ID
        # if oppty.opptyId               != opportunity["OpptyID"]                                      then change = true end
        # if oppty.opptyName             != opportunity["OpptyName"]                                    then change = true end
        # if oppty.idiqCA                != opportunity["IDIQ_CA"]                                      then change = true end
        # if oppty.status2               != opportunity["Status2"]                                      then change = true end
        # if oppty.value                 != opportunity["Total Value $M"]                               then change = true end
        # if oppty.pWin                  != opportunity["pWin"]                                         then change = true end
        # if oppty.captureMgr            != opportunity["Capturemgr"]										                then change = true end
        # if oppty.programMgr            != opportunity["ProgramMgr"]                                   then change = true end
        # if oppty.proposalMgr           != opportunity["ProposalMgr"]                                  then change = true end
        # if oppty.technicalLead         != opportunity["TechnicalLead"]                                then change = true end
         if oppty.slArch                != opportunity["SLArch"]                                       then change = true end
         if oppty.slComments            != opportunity["SL Comments"]                                  then change = true end
        # if oppty.rfpDate               != Date.new(1899,12,30) + opportunity["RFPDate"].to_f          then change = true end
        # if oppty.awardDate             != Date.new(1899,12,30) + opportunity["AwardDate"].to_f        then change = true end
         if oppty.slDir                 != opportunity["SLDir"]                                        then change = true end
         if oppty.leadEstim             != opportunity["LeadEstim"]                                    then change = true end
         if oppty.engaged               != opportunity["Engaged r/y/g"]                                then change = true end
         if oppty.solution              != opportunity["Solution r/y/g"]                               then change = true end
         if oppty.estimate              != opportunity["Estimate r/y/g"]                               then change = true end
        # if oppty.proposalDueDate       != Date.new(1899,12,30) + opportunity["ProposalDueDate"].to_f  then change = true end
        # if oppty.codeName              != opportunity["CodeName"]                                     then change = true end
        # if oppty.descriptionOfWork     != opportunity["DescriptionOfWork"]                            then change = true end
        # if oppty.category              != opportunity["Category"]                                     then change = true end
        # if oppty.pwald                 != opportunity["PWALD"]                                        then change = true end
        # if oppty.pBid                  != opportunity["pBid"]                                         then change = true end
        # if oppty.awardFV               != opportunity["AwardFV"]                                      then change = true end
        # if oppty.saicvaPercent         != opportunity["SAICVA%"]                                      then change = true end
        # if oppty.saicva                != opportunity["SAIC VA $M"]                                   then change = true end
        # if oppty.mat                   != opportunity["Mat%"]                                         then change = true end
        # if oppty.materialsTV           != opportunity["Mat TV $M"]                                    then change = true end
        # if oppty.subc                  != opportunity["Subc%"]                                        then change = true end
        # if oppty.subTV                 != opportunity["Subc TV $M"]                                   then change = true end
        # if oppty.cg_va                 != opportunity["CG_VA"]                                        then change = true end
        # if oppty.sss_va                != opportunity["SSS-3621"]                                     then change = true end
        # if oppty.nwi_va                != opportunity["NWI-3933"]                                     then change = true end
        # if oppty.hwi_va                != opportunity["HWI-3648"]                                     then change = true end
        # if oppty.tss_va                != opportunity["TSS-3676"]                                     then change = true end
        # if oppty.ccds_va               != opportunity["CCDS-3932"]                                    then change = true end
        # if oppty.mss_va                != opportunity["MSS-3690"]                                     then change = true end
        # if oppty.swi_va                != opportunity["SWI-3934"]                                     then change = true end
        # if oppty.lsc_va                != opportunity["LSC-3640"]                                     then change = true end
        # if oppty.zzOth_va              != opportunity["zzOth_VA"]                                     then change = true end
        # if oppty.pri                   != opportunity["Pri"]                                          then change = true end
        # if oppty.aop                   != opportunity["AOP"]                                          then change = true end
        # if oppty.peg                   != opportunity["PEG"]                                          then change = true end
        # if oppty.mustWin               != opportunity["MustWin"]                                      then change = true end
        # if oppty.feeIndic              != opportunity["FeeIndic"]                                     then change = true end
        # if oppty.slutil                != opportunity["Slutil"] 																		  then change = true end
        # if oppty.recompete             != opportunity["Recompete"] 																		then change = true end
        # if oppty.competitive           != opportunity["Competitive"] 																  then change = true end
        # if oppty.international         != opportunity["International"] 																then change = true end
        # if oppty.strategic             != opportunity["Strategic"] 																		then change = true end
        # if oppty.bundle                != opportunity["Bundle"] 																		  then change = true end
        # if oppty.bidReviewStream       != opportunity["BidReviewStream"] 															then change = true end
        # if oppty.definedDelivPgm       != opportunity["DefinedDelivPgm"] 															then change = true end
        # if oppty.evaluationCriteria    != opportunity["EvaluationCriteria"] 													then change = true end
        # if oppty.perfWorkLoc           != opportunity["PerfWorkLoc"] 																  then change = true end
        # if oppty.classIfReqmt          != opportunity["ClassifReqmt"] 																then change = true end
        # if oppty.grouping              != opportunity["Grouping"] 																		then change = true end
        # if oppty.reasonForWinLoss      != opportunity["ReasonforWinLoss"] 														then change = true end
        # if oppty.egr                   != opportunity["EGR"] 																		      then change = true end
        # if oppty.slCat                 != opportunity["SLcat"] 																		    then change = true end
        # if oppty.slPri                 != opportunity["Slpri"] 																		    then change = true end
        # if oppty.slNote                != opportunity["Slnote"] 																		  then change = true end
        # if oppty.crmRunDate            != opportunity["CRMRunDate"] 																  then change = true end
        # if oppty.contractStartDate     != opportunity["ContractStartDate"] 														then change = true end
        # if oppty.rfpFYPer              != opportunity["RFPFYPer"] 																		then change = true end
        # if oppty.submitFYPer           != opportunity["SubmitFYPer"] 																	then change = true end
        # if oppty.awardFYPer            != opportunity["AwardFYPer"] 																	then change = true end
        # if oppty.preBPprojID           != opportunity["PreBPprojID"] 																	then change = true end
        # if oppty.fy16PreBP             != opportunity["FY16 PreB&P$"] 																then change = true end
        # if oppty.fy16PreBPSpent        != opportunity["FY16 PreB&P $Spent"] 													then change = true end
        # if oppty.fy16PreBPSpentPercent != opportunity["FY16 PreB&P %Spent"] 													then change = true end
        # if oppty.bpProjID              != opportunity["BPprojID"] 																		then change = true end
        # if oppty.fy16BDTot             != opportunity["FY16 BDTot$"] 																	then change = true end
        # if oppty.fy16BDTotSpent        != opportunity["FY16 BDTot $Spent"] 														then change = true end
        # if oppty.fy16BDTotSpentPercent != opportunity["FY16 BDTot %Spent"] 														then change = true end
        # if oppty.financeDate           != opportunity["FinDate"] 																		  then change = true end
        # if oppty.cgSecOrg              != opportunity["SecOrg"] 																		  then change = true end
        # if oppty.cgSecMgr              != opportunity["SecMgr"] 																		  then change = true end
        # if oppty.cgOrg                 != opportunity["CGOrg"] 																		    then change = true end
        # if oppty.cgMgr                 != opportunity["CGMgr"] 																		    then change = true end
        # if oppty.                      != opportunity["OpOrg"] 																		    then change = true end
        # if oppty.cgOpMgr               != opportunity["OpMgr"] 																		    then change = true end
        # if oppty.cgPgmDir              != opportunity["PgmDir"] 																		  then change = true end
        # if oppty.bdMgr                 != opportunity["BDMgr"] 																		    then change = true end
        # if oppty.crmRecOwner           != opportunity["CRMRecOwner"] 																	then change = true end
        # if oppty.sslMgr                != opportunity["SSLeadMgr"] 																		then change = true end
        # if oppty.divNum                != opportunity["DivNum"] 																		  then change = true end
        # if oppty.customer              != opportunity["Customer"] 																		then change = true end
        # if oppty.endCustomer           != opportunity["endCustomer"] 																  then change = true end
        # if oppty.crn                   != opportunity["CRN"] 																		      then change = true end
        # if oppty.contractType          != opportunity["ContractType"] 																then change = true end
        # if oppty.opptyClass            != opportunity["OpptyClass"] 																	then change = true end
        # if oppty.numberOfAwards        != opportunity["NumberOfAwards"] 															then change = true end
        # if oppty.totalPOP              != opportunity["TotalPOP"] 																		then change = true end
        # if oppty.primeSub              != opportunity["PrimeSub"] 																		then change = true end
        # if oppty.fy16BP                != opportunity["FY16 B&P$"] 																		then change = true end
        # if oppty.fy16BPSpent           != opportunity["FY16 B&P $Spent"] 															then change = true end
        # if oppty.fy16BPSpentPercent    != opportunity["FY16 B&P %Spent"] 															then change = true end
        if change == true
          @changes.push(id)
        end
      else # else not in database, add it
        @added += 1
      end
    end
    Oppty.find_each do |o|
      opptyIds.push(o.opptyId)
    end
    puts "changes: " + @changes.length.to_s
    puts "newCount: " + @added.to_s
    puts "opptyLength: " + opptyIds.length.to_s
    puts "uploadedLength: " + uploadedIds.length.to_s
    puts "deletedCount: " + (opptyIds - uploadedIds).length.to_s
    #puts opptyIds
    @deleted=0
    # @added
    uploadedIds.each do |u|
      opptyIds.delete(u)
    end
    # puts "*"*30
    # opptyIds.each do |i|
    #   #puts i
    #   @deleted+=1
    #   moveToHistory(i)
    # end
    puts "*"*30
    @deleted = (opptyIds - uploadedIds).length.to_s
    @uploaded=true
    render :index
  end

  #downloading the modified excel file from the browser
  def download
    #pull the database data into an excel
    #pulls and downloads the first .xlsm file from the /uploads folder
    if Dir[CRM_PATH+'/*.xlsm'][0]
        @download_path=File.join(Dir[CRM_PATH+'/*.xlsm'][0])
        name = @download_path.gsub("new_", "")
        puts "*"*30
        puts name
        puts @download_path
        puts "*"*30
        puts `ls /home/server/crm-manager-server/public/uploads`
        puts "*"*30
        `mv "#{@download_path}" "#{name}"`
        send_file name, :type=>"application/txt", :x_sendfile=>true
        `mv "#{name}" "#{@download_path}"`
        puts "z"*30
        puts `ls /home/server/crm-manager-server/public/uploads`
    else
        redirect_to crm_index_path
    end
  end
end
