class CrmController < ApplicationController
  CRM_PATH = File.join(Rails.root, "public", "uploads")
  def index
    delete
    @uploaded=false
  end
  def checkDate
    uploaded_io = params[:upl]
    if !uploaded_io.present?
      redirect_to crm_index_path, notice: "Please upload a file"
      return
    end

    FileUtils.mkdir_p(CRM_PATH) unless File.directory?(CRM_PATH)
    FileUtils.mkdir_p('public/uploads/data') unless File.directory?('public/uploads/data')
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
    puts "newFileName: " + @newFileName
    # hacks to clear uploads folder
    # move files we care about up one directory
    `mv public/uploads/"#{@newFileName}" public/`
    `mv public/uploads/#{@oldFileName} public/`
    `rm public/uploads/*` # delete everything in uploads
    `mv public/"#{@newFileName}" public/uploads/"#{@newFileName}"` # move files back from upper directory
    `mv public/#{@oldFileName} public/uploads/#{@oldFileName}`
    @oldOrNew = "old"
    if Dir[CRM_PATH+ '/*.xlsm'].length > 1 # if there is more than one file, check if older/newer
      @oldOrNew =  `python bin/dateExtract.py "public/uploads/#{@newFileName}" "public/uploads/#{@oldFileName}"`
    else
      @oldOrNew = "new" # else just say it's new
    end
    nonSpaceName = CRM_PATH + "/" + @newFileName
    @newFileName = @newFileName.gsub(" ", "%20")
    File.rename(nonSpaceName, CRM_PATH + "/" + @newFileName)
    puts "*"*30, @newFileName, "*"*30
    render :index

  end
# after submit is pushed
  def updateCRM
    # oldFileName
    # newFileName
    puts "z"*100
    oldFileName=params[:old]
    newFileName=params[:new]
    changes=params[:changes]
    changes = JSON.parse(changes)
    if Dir[CRM_PATH+ '/*.xlsm'].length > 1
      `rm #{CRM_PATH}/#{oldFileName}`
    end
    opptyIds = [] # holds ids in the database
    Oppty.find_each do |o|
      opptyIds.push(o.opptyId) # get all ids in database
    end
    data = `python bin/excelReader.py "public/uploads/#{newFileName}"` # get parsed excel data
    data = JSON.parse(data)
    uploadedIds = [] # holds uploaded ids
    data.each do |d|
      uploadedIds.push(d["OpptyID"]) # holds all ids in the excel
    end
    ids = opptyIds - uploadedIds # ids = everything in opptyIds and NOT in uploadedIds, the ones to be moved to history
    newIds = uploadedIds - opptyIds # new - old = new ones to add
    if changes.any?
      changes.each do |c|
        if History.find_by(opptyId:c) # if in history delete from history, add new one, move to history
          History.find_by(opptyId:c).delete
          newIds.push(c)
          ids.push(c) # because hax
        else
          Oppty.find_by(opptyId:c).delete
          newIds.push(c)
        end
      end
    end

    addNewOppty(data, newIds, uploadedIds)
    ids.each do |i|
      moveToHistory(i)
    end
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
      @oppty.crmRunDate            = Date.new(1899,12,30) + opportunity["CRMRunDate"].to_f
      @oppty.contractStartDate     = Date.new(1899,12,30) + opportunity["ContractStartDate"].to_f
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
      @oppty.financeDate           = Date.new(1899,12,30) + opportunity["FinDate"].to_f
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

  def delete
    if Dir[CRM_PATH + '/*.xlsm'].length > 1 #if there is more than one file, delete the old one. else the new overwrote the old, don't delete
      earliest_file_name=""
      earliest_date=Time.new
      Dir[CRM_PATH + '/*.xlsm'].each do |item|
        next if item == '.' or item == '..'
        puts "*"*30
        puts item
        puts "*"*30
        puts "creation Time: "+File.ctime(item).to_s
        puts "Earliest_time: "+earliest_date.to_s
        if (File.ctime(item)<earliest_date)
          earliest_file_name=item
          earliest_date=File.ctime(item)
        end
      end
      puts "*"*30
      puts earliest_file_name
      puts earliest_date
      puts "*"*30
      FileUtils.mv(earliest_file_name,   File.join(Rails.root, "public", File.basename(earliest_file_name)))
      FileUtils.rm_rf(Dir.glob(CRM_PATH+'/*'))
      FileUtils.mv(File.join(Rails.root, "public", File.basename(earliest_file_name)),earliest_file_name)
    end
  end

  #uploading an excel file from user's computer
  def upload
    puts "*"*30, params[:newFileName], "*"*30
    puts params[:oldFileName]
    @newFileName=params[:newFileName]
    @oldFileName=params[:oldFileName]
    `python bin/ripExcel.py "public/uploads/#{@newFileName}" "public/uploads/data/"`
    data = `python bin/excelReader.py "public/uploads/#{@newFileName}"`
    data = JSON.parse(data)
    @changes = [] # holds list of hashes that contain what is changed
    @added = 0
    uploadedIds=[]
    opptyIds=[]
    change = false
    id = 0
    @equal = 0
    data.each do |opportunity| # for all the opportunities
      change = false
      id = opportunity["OpptyID"] # get the id
      uploadedIds.push(id)
      oppty = Oppty.find_by(opptyId:id)
      if oppty != nil && id == oppty.opptyId # check if the oppty is in the database
        # if the cell changed, hashtable contains the new value and ID
        diff = Hash.new
        diff.default = 0
        change = false
        id                    = opportunity["OpptyID"]
        name                  = opportunity["OpptyName"]
        idiqCA                = opportunity["IDIQ_CA"]
        status2               = opportunity["Status2"]
        value                 = opportunity["Total Value $M"]
        pWin                  = opportunity["pWin"]
        captureMgr            = opportunity["Capturemgr"]
        programMgr            = opportunity["ProgramMgr"]
        proposalMgr           = opportunity["ProposalMgr"]
        technicalLead         = opportunity["TechnicalLead"]
        slArch                = opportunity["SLArch"]
        slComments            = opportunity["SL Comments"]
        rfpDate               = Date.new(1899,12,30) + opportunity["RFPDate"].to_f
        awardDate             = Date.new(1899,12,30) + opportunity["AwardDate"].to_f
        slDir                 = opportunity["SLDir"]
        leadEstim             = opportunity["LeadEstim"]
        engaged               = opportunity["Engaged r/y/g"]
        solution              = opportunity["Solution r/y/g"]
        estimate              = opportunity["Estimate r/y/g"]
        proposalDueDate       = Date.new(1899,12,30) + opportunity["ProposalDueDate"].to_f
        codeName              = opportunity["CodeName"]
        descriptionOfWork     = opportunity["DescriptionOfWork"]
        category              = opportunity["Category"]
        pwald                 = opportunity["PWALD"]
        pBid                  = opportunity["pBid"]
        awardFV               = opportunity["AwardFV"]
        saicvaPercent         = opportunity["SAICVA%"]
        saicva                = opportunity["SAIC VA $M"]
        mat                   = opportunity["Mat%"]
        materialsTV           = opportunity["Mat TV $M"]
        subc                  = opportunity["Subc%"]
        subTV                 = opportunity["Subc TV $M"]
        cg_va                 = opportunity["CG_VA"]
        sss_va                = opportunity["SSS-3621"] # i have no idea why
        nwi_va                = opportunity["NWI-3933"]
        hwi_va                = opportunity["HWI-3648"]
        itms_va               = opportunity["ITMS-3896"]
        tss_va                = opportunity["TSS-3676"]
        ccds_va               = opportunity["CCDS-3932"]
        mss_va                = opportunity["MSS-3690"]
        swi_va                = opportunity["SWI-3934"]
        lsc_va                = opportunity["LSC-3640"]
        zzOth_va              = opportunity["zzOth_VA"]
        pri                   = opportunity["Pri"]
        aop                   = opportunity["AOP"]
        peg                   = opportunity["PEG"]
        mustWin               = opportunity["MustWin"]
        feeIndic              = opportunity["FeeIndic"]
        slutil                = opportunity["Slutil"]
        recompete             = opportunity["Recompete"]
        competitive           = opportunity["Competitive"]
        international         = opportunity["International"]
        strategic             = opportunity["Strategic"]
        bundle                = opportunity["Bundle"]
        bidReviewStream       = opportunity["BidReviewStream"]
        definedDelivPgm       = opportunity["DefinedDelivPgm"]
        evaluationCriteria    = opportunity["EvaluationCriteria"]
        perfWorkLoc           = opportunity["PerfWorkLoc"]
        classIfReqmt          = opportunity["ClassifReqmt"]
        grouping              = opportunity["Grouping"]
        reasonForWinLoss      = opportunity["ReasonforWinLoss"]
        egr                   = opportunity["EGR"]
        slCat                 = opportunity["SLcat"]
        slPri                 = opportunity["Slpri"]
        slNote                = opportunity["Slnote"]
        crmRunDate            = Date.new(1899,12,30) + opportunity["CRMRunDate"].to_f
        contractStartDate     = Date.new(1899,12,30) + opportunity["ContractStartDate"].to_f
        rfpFYPer              = opportunity["RFPFYPer"]
        submitFYPer           = opportunity["SubmitFYPer"]
        awardFYPer            = opportunity["AwardFYPer"]
        preBPprojID           = opportunity["PreBPprojID"]
        fy16PreBP             = opportunity["FY16 PreB&P$"]
        fy16PreBPSpent        = opportunity["FY16 PreB&P $Spent"]
        fy16PreBPSpentPercent = opportunity["FY16 PreB&P %Spent"]
        bpProjID              = opportunity["BPprojID"]
        fy16BDTot             = opportunity["FY16 BDTot$"]
        fy16BDTotSpent        = opportunity["FY16 BDTot $Spent"]
        fy16BDTotSpentPercent = opportunity["FY16 BDTot %Spent"]
        financeDate           = Date.new(1899,12,30) + opportunity["FinDate"].to_f
        cgSecOrg              = opportunity["SecOrg"]
        cgSecMgr              = opportunity["SecMgr"]
        cgOrg                 = opportunity["CGOrg"]
        cgMgr                 = opportunity["CGMgr"]
        opOrg                 = opportunity["OpOrg"]
        cgOpMgr               = opportunity["OpMgr"]
        cgPgmDir              = opportunity["PgmDir"]
        bdMgr                 = opportunity["BDMgr"]
        crmRecOwner           = opportunity["CRMRecOwner"]
        sslMgr                = opportunity["SSLeadMgr"]
        divNum                = opportunity["DivNum"]
        customer              = opportunity["Customer"]
        endCustomer           = opportunity["EndCustomer"]
        crn                   = opportunity["CRN"]
        contractType          = opportunity["ContractType"]
        opptyClass            = opportunity["OpptyClass"]
        numberOfAwards        = opportunity["NumberOfAwards"]
        totalPOP              = opportunity["TotalPOP"]
        primeSub              = opportunity["PrimeSub"]
        fy16BP                = opportunity["FY16 B&P$"]
        fy16BPSpent           = opportunity["FY16 B&P $Spent"]
        fy16BPSpentPercent    = opportunity["FY16 B&P %Spent"]
      # if the cell changed, hashtable contains the new value a     nd ID

				if name                     != oppty.opptyName                then diff ["opptyName"]               = name end
				if idiqCA                   != oppty.idiqCA                   then diff ["idiqCA"]                  = idiqCA end
				if status2                  != oppty.status2                  then diff ["status2"]                 = status2 end
				if value                    != oppty.value                    then diff ["value"]                   = value end
				if pWin                     != oppty.pWin                     then diff ["pWin"]                    = pWin end
				if captureMgr               != oppty.captureMgr               then diff ["captureMgr"]              = captureMgr end
				if programMgr               != oppty.programMgr               then diff ["programMgr"]              = programMgr end
				if proposalMgr              != oppty.proposalMgr              then diff ["proposalMgr"]             = proposalMgr end
				if technicalLead            != oppty.technicalLead            then diff ["technicalLead"]           = technicalLead end
				if slArch                   != oppty.slArch                   then diff ["slArch"]                  = slArch end
				if slComments               != oppty.slComments               then diff ["slComments"]              = slComments end
				if rfpDate                  != oppty.rfpDate                  then diff ["rfpDate"]                 = rfpDate end
				if awardDate                != oppty.awardDate                then diff ["awardDate"]               = awardDate end
				if slDir                    != oppty.slDir                    then diff ["slDir"]                   = slDir end
				if leadEstim                != oppty.leadEstim                then diff ["leadEstim"]               = leadEstim end
				if engaged                  != oppty.engaged                  then diff ["engaged"]                 = engaged end
				if solution                 != oppty.solution                 then diff ["solution"]                = solution end
				if estimate                 != oppty.estimate                 then diff ["estimate"]                = estimate end
				if proposalDueDate          != oppty.proposalDueDate          then diff ["proposalDueDate"]         = proposalDueDate end
				if codeName                 != oppty.codeName                 then diff ["codeName"]                = codeName end
				if descriptionOfWork        != oppty.descriptionOfWork        then diff ["descriptionOfWork"]       = descriptionOfWork end
				if category                 != oppty.category                 then diff ["category"]                = category end
				if pwald                    != oppty.pwald                    then diff ["pwald"]                   = pwald end
				if pBid                     != oppty.pBid                     then diff ["pBid"]                    = pBid end
				if awardFV                  != oppty.awardFV                  then diff ["awardFV"]                 = awardFV end
				if saicvaPercent            != oppty.saicvaPercent            then diff ["saicvaPercent"]           = saicvaPercent end
				if mat                      != oppty.mat                      then diff ["mat"]                     = mat end
				if materialsTV              != oppty.materialsTV              then diff ["materialsTV"]             = materialsTV end
				if subc                     != oppty.subc                     then diff ["subc"]                    = subc end
				if subTV                    != oppty.subTV                    then diff ["subTV"]                   = subTV end
				if cg_va                    != oppty.cg_va                    then diff ["cg_va"]                   = cg_va end
				if sss_va                   != oppty.sss_va                   then diff ["sss_va"]                  = sss_va end
				if nwi_va                   != oppty.nwi_va                   then diff ["nwi_va"]                  = nwi_va end
				if hwi_va                   != oppty.hwi_va                   then diff ["hwi_va"]                  = hwi_va end
				if itms_va                  != oppty.itms_va                  then diff ["itms_va"]                 = itms_va end
				if tss_va                   != oppty.tss_va                   then diff ["tss_va"]                  = tss_va end
				if ccds_va                  != oppty.ccds_va                  then diff ["ccds_va"]                 = ccds_va end
				if mss_va                   != oppty.mss_va                   then diff ["mss_va"]                  = mss_va end
				if swi_va                   != oppty.swi_va                   then diff ["swi_va"]                  = swi_va end
				if lsc_va                   != oppty.lsc_va                   then diff ["lsc_va"]                  = lsc_va end
				if zzOth_va                 != oppty.zzOth_va                 then diff ["zzOth_va"]                = zzOth_va end
				if pri                      != oppty.pri                      then diff ["pri"]                     = pri end
				if aop                      != oppty.aop                      then diff ["aop"]                     = aop end
				if peg                      != oppty.peg                      then diff ["peg"]                     = peg end
				if mustWin                  != oppty.mustWin                  then diff ["mustWin"]                 = mustWin end
				if feeIndic                 != oppty.feeIndic                 then diff ["feeIndic"]                = feeIndic end
				if slutil                   != oppty.slutil                   then diff ["slutil"]                  = slutil end
				if recompete                != oppty.recompete                then diff ["recompete"]               = recompete end
				if competitive              != oppty.competitive              then diff ["competitive"]             = competitive end
				if international            != oppty.international            then diff ["international"]           = international end
				if strategic                != oppty.strategic                then diff ["strategic"]               = strategic end
				if bundle                   != oppty.bundle                   then diff ["bundle"]                  = bundle end
				if bidReviewStream          != oppty.bidReviewStream          then diff ["bidReviewStream"]         = bidReviewStream end
				if definedDelivPgm          != oppty.definedDelivPgm          then diff ["definedDelivPgm"]         = definedDelivPgm end
				if evaluationCriteria       != oppty.evaluationCriteria       then diff ["evaluationCriteria"]      = evaluationCriteria end
				if perfWorkLoc              != oppty.perfWorkLoc              then diff ["perfWorkLoc"]             = perfWorkLoc end
				if classIfReqmt             != oppty.classIfReqmt             then diff ["classIfReqmt"]            = classIfReqmt end
				if grouping                 != oppty.grouping                 then diff ["grouping"]                = grouping end
				if reasonForWinLoss         != oppty.reasonForWinLoss         then diff ["reasonForWinLoss"]        = reasonForWinLoss end
				if egr                      != oppty.egr                      then diff ["egr"]                     = egr end
				if slCat                    != oppty.slCat                    then diff ["slCat"]                   = slCat end
				if slPri                    != oppty.slPri                    then diff ["slPri"]                   = slPri end
				if slNote                   != oppty.slNote                   then diff ["slNote"]                  = slNote end
				if crmRunDate               != oppty.crmRunDate               then diff ["crmRunDate"]              = crmRunDate end
				if contractStartDate        != oppty.contractStartDate        then diff ["contractStartDate"]       = contractStartDate end
				if rfpFYPer                 != oppty.rfpFYPer                 then diff ["rfpFYPer"]                = rfpFYPer end
				if submitFYPer              != oppty.submitFYPer              then diff ["submitFYPer"]             = submitFYPer end
				if awardFYPer               != oppty.awardFYPer               then diff ["awardFYPer"]              = awardFYPer end
				if preBPprojID              != oppty.preBPprojID              then diff ["preBPprojID"]             = preBPprojID end
				if fy16PreBP                != oppty.fy16PreBP                then diff ["fy16PreBP"]               = fy16PreBP end
				if fy16PreBPSpent           != oppty.fy16PreBPSpent           then diff ["fy16PreBPSpent"]          = fy16PreBPSpent end
				#if fy16PreBPSpentPercent    != oppty.fy16PreBPSpentPercent    then diff ["fy16PreBPSpentPercent"]   = fy16PreBPSpentPercent   end
				if bpProjID                 != oppty.bpProjID                 then diff ["bpProjID"]                = bpProjID end
				if fy16BDTot                != oppty.fy16BDTot                then diff ["fy16BDTot"]               = fy16BDTot end
				if fy16BDTotSpent           != oppty.fy16BDTotSpent           then diff ["fy16BDTotSpent"]          = fy16BDTotSpent end
				#if fy16BDTotSpentPercent    != oppty.fy16BDTotSpentPercent    then diff ["fy16BDTotSpentPercent"]   = fy16BDTotSpentPercent   end
				if financeDate              != oppty.financeDate              then diff ["financeDate"]             = financeDate end
				if cgSecOrg                 != oppty.cgSecOrg                 then diff ["cgSecOrg"]                = cgSecOrg end
				if cgSecMgr                 != oppty.cgSecMgr                 then diff ["cgSecMgr"]                = cgSecMgr end
				if cgOrg                    != oppty.cgOrg                    then diff ["cgOrg"]                   = cgOrg end
				if cgMgr                    != oppty.cgMgr                    then diff ["cgMgr"]                   = cgMgr end
				if opOrg                    != oppty.opOrg                    then diff ["opOrg"]                   = opOrg end
				if cgOpMgr                  != oppty.cgOpMgr                  then diff ["cgOpMgr"]                 = cgOpMgr end
				if cgPgmDir                 != oppty.cgPgmDir                 then diff ["cgPgmDir"]                = cgPgmDir end
				if bdMgr                    != oppty.bdMgr                    then diff ["bdMgr"]                   = bdMgr end
				if crmRecOwner              != oppty.crmRecOwner              then diff ["crmRecOwner"]             = crmRecOwner end
				if sslMgr                   != oppty.sslMgr                   then diff ["sslMgr"]                  = sslMgr end
				if divNum                   != oppty.divNum                   then diff ["divNum"]                  = divNum end
				if customer                 != oppty.customer                 then diff ["customer"]                = customer end
				if endCustomer              != oppty.endCustomer              then diff ["endCustomer"]             = endCustomer end
				if crn                      != oppty.crn                      then diff ["crn"]                     = crn end
				if contractType             != oppty.contractType             then diff ["contractType"]            = contractType end
				if opptyClass               != oppty.opptyClass               then diff ["opptyClass"]              = opptyClass end
				if numberOfAwards           != oppty.numberOfAwards           then diff ["numberOfAwards"]          = numberOfAwards end
				if totalPOP                 != oppty.totalPOP                 then diff ["totalPOP"]                = totalPOP end
				if primeSub                 != oppty.primeSub                 then diff ["primeSub"]                = primeSub end
				if fy16BP                   != oppty.fy16BP                   then diff ["fy16BP"]                  = fy16BP end
				if fy16BPSpent              != oppty.fy16BPSpent              then diff ["fy16BPSpent"]             = fy16BPSpent end
        # "0Budget"
        # if fy16BPSpentPercent   != data.fy16BPSpentPercent
        #   diff["fy16BPSpentPercent"]  = fy16BPSpentPercent
        #   change = true end
        if diff.length > 0 # if there are any changes
          # because if we input "" into the database, it goes in as nil
          # instead of "", so check if that's what happened, and if true, ignore
          to_push = false
          diff.each do |key, value|
            if value == "" #nil != ""
              next
              #diff.delete(key)
            else
              #puts value
              to_push = true
              #break
            end
          end
          if to_push == true
            @changes.push(id) # add hash to list
          else
            @equal += 1
          end
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
    puts "equalCount: " + @equal.to_s
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
    @deleted = (opptyIds - uploadedIds).length.to_s
    @uploaded=true
    render :index
  end

  def reconstruct(excelFileName)
      #reconstruct excel file
      puts "*"*30, excelFileName
      arg = "["
      oppty = Oppty.all
      oppty.each do |o|
        arg << '[\'' + o.opptyId + '\', \'' + 'slDir' + '\', \'' + o.slDir + '\'], '
        arg << '[\'' + o.opptyId + '\', \'' + 'slArch' + '\', \'' + o.slArch + '\'], '
        arg << '[\'' + o.opptyId + '\', \'' + 'leadEstim' + '\', \'' + o.leadEstim + '\'], '
        arg << '[\'' + o.opptyId + '\', \'' + 'engaged' + '\', \'' + o.engaged + '\'], '
        arg << '[\'' + o.opptyId + '\', \'' + 'solution' + '\', \'' + o.solution + '\'], '
        arg << '[\'' + o.opptyId + '\', \'' + 'estimate' + '\', \'' + o.estimate + '\'], '
        arg << '[\'' + o.opptyId + '\', \'' + 'slComments' + '\', \'' + o.slComments + '\'], '
      end
      arg = arg[0..-3]
      arg <<"]"
      #puts arg
      HardWorker.perform_async(excelFileName, arg)
    end

  #downloading the modified excel file from the browser
  def download
    #pull the database data into an excel
    #pulls and downloads the first .xlsm file from the /uploads folder
    download_path=""
    if Dir[CRM_PATH + '/*.xlsm'].length > 1 #if there is more than one file, delete the old one. else the new overwrote the old, don't delete
      earliest_file_name=""
      earliest_date=Time.new
      Dir[CRM_PATH + '/*.xlsm'].each do |item|
        next if item == '.' or item == '..'
        puts "*"*30
        puts item
        puts "*"*30
        puts "creation Time: "+File.ctime(item).to_s
        puts "Earliest_time: "+earliest_date.to_s
        if (File.ctime(item)<earliest_date)
          earliest_file_name=item
          earliest_date=File.ctime(item)
        end
      end
      download_path= earliest_file_name
    else if Dir[CRM_PATH+'/*.xlsm'].length==1
      download_path=File.join(Dir[CRM_PATH+'/*.xlsm'][0])
    else
      redirect_to crm_index_path, notice: "Please upload a file"
    end

    end
    if download_path!=""
      reconstruct(download_path)
      name = download_path.gsub("new_", "")
      File.rename download_path, name
      file = File.open(name, "rb")
      contents = file.read
      file.close
      File.rename name, download_path
      send_data(contents, :filename =>File.basename( name))
    end
  end
end
