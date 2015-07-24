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
      # if the cell changed, hashtable contains the new value and ID
        if name              != oppty.opptyName
          diff["opptyName"]        = name
          change = true end
        if idiqCA            != oppty.idiqCA
          diff["idiqCA"]           = idiqCA
          change = true end
        if status2           != oppty.status2
          diff["status2"]          = status2
          change = true end
        if value             != oppty.value
          diff["value"]            = value
          change = true end
        #########Potential loating point inaccuracies, however per we believe this is inconsequential ###########
        if pWin             != oppty.pWin
          diff["pWin"]            = pWin
          change = true end
        if captureMgr        != oppty.captureMgr
          diff["captureMgr"]       = captureMgr
          change = true end
        if programMgr        != oppty.programMgr
          diff["programMgr"]       = programMgr
          change = true end
        if proposalMgr       != oppty.proposalMgr
          diff["proposalMgr"]      = proposalMgr
          change = true end
        if technicalLead     != oppty.technicalLead
          diff["technicalLead"]    = technicalLead
          change = true end
        if slArch            != oppty.slArch
          diff["slArch"]           = slArch
          change = true end
        if slComments        != oppty.slComments
          diff["slComments"]       = slComments
          change = true end
        if rfpDate           != oppty.rfpDate
          diff["rfpDate"]          = rfpDate
          change = true end
        if awardDate         != oppty.awardDate
          diff["awardDate"]        = awardDate
          change = true end
        if slDir             != oppty.slDir
          diff["slDir"]            = slDir
          change = true end
        if leadEstim         != oppty.leadEstim
          diff["leadEstim"]        = leadEstim
          change = true end
        if engaged           != oppty.engaged
          diff["engaged"]          = engaged
          change = true end
        if solution          != oppty.solution
          diff["solution"]         = solution
          change = true end
        if estimate          != oppty.estimate
          diff["estimate"]         = estimate
          change = true end
        if proposalDueDate   != oppty.proposalDueDate
          diff["proposalDueDate"]  = proposalDueDate
          change = true end
        if codeName   != oppty.codeName
          diff["codeName"]  = codeName
          change = true end
        if descriptionOfWork   != oppty.descriptionOfWork
          diff["descriptionOfWork"]  = descriptionOfWork
          change = true end
        if category   != oppty.category
          diff["category"]  = category
          change = true end
        if pwald   != oppty.pwald
          diff["pwald"]  = pwald
          change = true end
        if pBid   != oppty.pBid
          diff["pBid"]  = pBid
          change = true end
        if awardFV   != oppty.awardFV
          diff["awardFV"]  = awardFV
          change = true end
        if saicvaPercent   != oppty.saicvaPercent
          diff["saicvaPercent"]  = saicvaPercent
          change = true end
        if mat   != oppty.mat
          diff["mat"]  = mat
          change = true end
        if materialsTV   != oppty.materialsTV
          diff["materialsTV"]  = materialsTV
          change = true end
        if subc   != oppty.subc
          diff["subc"]  = subc
          change = true end
        if subTV   != oppty.subTV
          diff["subTV"]  = subTV
          change = true end
        if cg_va   != oppty.cg_va
          diff["cg_va"]  = cg_va
          change = true end
        if sss_va   != oppty.sss_va
          diff["sss_va"]  = sss_va
          change = true end
        if nwi_va   != oppty.nwi_va
          diff["nwi_va"]  = nwi_va
          change = true end
        if hwi_va   != oppty.hwi_va
          diff["hwi_va"]  = hwi_va
          change = true end
        if itms_va   != oppty.itms_va
          diff["itms_va"]  = itms_va
          change = true end
        if tss_va   != oppty.tss_va
          diff["tss_va"]  = tss_va
          change = true end
        if ccds_va   != oppty.ccds_va
          diff["ccds_va"]  = ccds_va
          change = true end
        if mss_va   != oppty.mss_va
          diff["mss_va"]  = mss_va
          change = true end
        if swi_va   != oppty.swi_va
          diff["swi_va"]  = swi_va
          change = true end
        if lsc_va   != oppty.lsc_va
          diff["lsc_va"]  = lsc_va
          change = true end
        if zzOth_va   != oppty.zzOth_va
          diff["zzOth_va"]  = zzOth_va
          change = true end
        if pri   != oppty.pri
          diff["pri"]  = pri
          change = true end
        if aop   != oppty.aop
          diff["aop"]  = aop
          change = true end
        if peg   != oppty.peg
          diff["peg"]  = peg
          change = true end
        if mustWin   != oppty.mustWin
          diff["mustWin"]  = mustWin
          change = true end
        if feeIndic   != oppty.feeIndic
          diff["feeIndic"]  = feeIndic
          change = true end
        if slutil   != oppty.slutil
          diff["slutil"]  = slutil
          change = true end
        if recompete   != oppty.recompete
          diff["recompete"]  = recompete
          change = true end
        if competitive   != oppty.competitive
          diff["competitive"]  = competitive
          change = true end
        if international   != oppty.international
          diff["international"]  = international
          change = true end
        if strategic   != oppty.strategic
          diff["strategic"]  = strategic
          change = true end
        if bundle   != oppty.bundle
          diff["bundle"]  = bundle
          change = true end
        if bidReviewStream   != oppty.bidReviewStream
          diff["bidReviewStream"]  = bidReviewStream
          change = true end
        if definedDelivPgm   != oppty.definedDelivPgm
          diff["definedDelivPgm"]  = definedDelivPgm
          change = true end
        if evaluationCriteria   != oppty.evaluationCriteria
          diff["evaluationCriteria"]  = evaluationCriteria
          change = true end
        if perfWorkLoc   != oppty.perfWorkLoc
          diff["perfWorkLoc"]  = perfWorkLoc
          change = true end
        if classIfReqmt   != oppty.classIfReqmt
          diff["classIfReqmt"]  = classIfReqmt
          change = true end
        if grouping   != oppty.grouping
          diff["grouping"]  = grouping
          change = true end
        if reasonForWinLoss   != oppty.reasonForWinLoss
          diff["reasonForWinLoss"]  = reasonForWinLoss
          change = true end
        if egr   != oppty.egr
          diff["egr"]  = egr
          change = true end
        if slCat   != oppty.slCat
          diff["slCat"]  = slCat
          change = true end
        if slPri   != oppty.slPri
          diff["slPri"]  = slPri
          change = true end
        if slNote   != oppty.slNote
          diff["slNote"]  = slNote
          change = true end
        if crmRunDate   != oppty.crmRunDate
          diff["crmRunDate"]  = crmRunDate
          change = true end
        if contractStartDate   != oppty.contractStartDate
          diff["contractStartDate"]  = contractStartDate
          change = true end
        if rfpFYPer   != oppty.rfpFYPer
          diff["rfpFYPer"]  = rfpFYPer
          change = true end
        if submitFYPer   != oppty.submitFYPer
          diff["submitFYPer"]  = submitFYPer
          change = true end
        if awardFYPer   != oppty.awardFYPer
          diff["awardFYPer"]  = awardFYPer
          change = true end
        if preBPprojID   != oppty.preBPprojID
          diff["preBPprojID"]  = preBPprojID
          change = true end
        if fy16PreBP   != oppty.fy16PreBP
          diff["fy16PreBP"]  = fy16PreBP
          change = true end
        if fy16PreBPSpent   != oppty.fy16PreBPSpent
          diff["fy16PreBPSpent"]  = fy16PreBPSpent
          change = true end
        # for some reason this sometimes has the value "0Budget" which can be seen in the excelsheet
        # if fy16PreBPSpentPercent   != oppty.fy16PreBPSpentPercent
        #   diff["fy16PreBPSpentPercent"]  = fy16PreBPSpentPercent
        #   change = true end
        if bpProjID   != oppty.bpProjID
          diff["bpProjID"]  = bpProjID
          change = true end
        if fy16BDTot   != oppty.fy16BDTot
          diff["fy16BDTot"]  = fy16BDTot
          change = true end
        if fy16BDTotSpent   != oppty.fy16BDTotSpent
          diff["fy16BDTotSpent"]  = fy16BDTotSpent
          change = true end
        # "0Budget" issue
        # if fy16BDTotSpentPercent   != oppty.fy16BDTotSpentPercent
        #   diff["fy16BDTotSpentPercent"]  = fy16BDTotSpentPercent
        #   change = true end
        if financeDate   != oppty.financeDate
          diff["financeDate"]  = financeDate
          change = true end
        if cgSecOrg   != oppty.cgSecOrg
          diff["cgSecOrg"]  = cgSecOrg
          change = true end
        if cgSecMgr   != oppty.cgSecMgr
          diff["cgSecMgr"]  = cgSecMgr
          change = true end
        if cgOrg   != oppty.cgOrg
          diff["cgOrg"]  = cgOrg
          change = true end
        if cgMgr   != oppty.cgMgr
          diff["cgMgr"]  = cgMgr
          change = true end
        if opOrg   != oppty.opOrg
          diff["opOrg"]  = opOrg
          change = true end
        if cgOpMgr   != oppty.cgOpMgr
          diff["cgOpMgr"]  = cgOpMgr
          change = true end
        if cgPgmDir   != oppty.cgPgmDir
          diff["cgPgmDir"]  = cgPgmDir
          change = true end
        if bdMgr   != oppty.bdMgr
          diff["bdMgr"]  = bdMgr
          change = true end
        if crmRecOwner   != oppty.crmRecOwner
          diff["crmRecOwner"]  = crmRecOwner
          change = true end
        if sslMgr   != oppty.sslMgr
          diff["sslMgr"]  = sslMgr
          change = true end
        if divNum   != oppty.divNum
          diff["divNum"]  = divNum
          change = true end
        if customer   != oppty.customer
          diff["customer"]  = customer
          change = true end
        if endCustomer   != oppty.endCustomer
          diff["endCustomer"]  = endCustomer
          change = true end
        if crn   != oppty.crn
          diff["crn"]  = crn
          change = true end
        if contractType   != oppty.contractType
          diff["contractType"]  = contractType
          change = true end
        if opptyClass   != oppty.opptyClass
          diff["opptyClass"]  = opptyClass
          change = true end
        if numberOfAwards   != oppty.numberOfAwards
          diff["numberOfAwards"]  = numberOfAwards
          change = true end
        if totalPOP   != oppty.totalPOP
          diff["totalPOP"]  = totalPOP
          change = true end
        if primeSub   != oppty.primeSub
          diff["primeSub"]  = primeSub
          change = true end
        if fy16BP   != oppty.fy16BP
          diff["fy16BP"]  = fy16BP
          change = true end
        if fy16BPSpent   != oppty.fy16BPSpent
          diff["fy16BPSpent"]  = fy16BPSpent
          change = true end
        # "0Budget"
        # if fy16BPSpentPercent   != data.fy16BPSpentPercent
        #   diff["fy16BPSpentPercent"]  = fy16BPSpentPercent
        #   change = true end
        if change == true
          # because if we input "" into the database, it goes in as nil
          # instead of "", so check if that's what happened, and if true, ignore
          to_push = false
          diff.each do |key, value|
            if value == "" #nil != ""
              diff.delete(key)
            else
              print value
              to_push = true
              #break
            end
          end
          if to_push == true
            @changes.push(id) # add hash to list
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
