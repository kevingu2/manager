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
    puts oldFileName
    puts newFileName
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
    ids.each do |i|
      moveToHistory(i)
    end
    addNewOppty(data, newIds, uploadedIds)
    redirect_to crm_index_path
  end

  def addNewOppty(data, newIds, uploadedIds)
    data.each do |o|
      if !newIds.include? o["OpptyID"] then next end # if id not supposed to be added, skip
      uploadedIds.push(o["OpptyID"])
      #if there is some magical ruby way to do this better, please do it. I don't know ruby :(
      #quite possibly the hackiest code in this project
      #######################get values from json##########################

      @oppty=Oppty.new
      #fields
      @oppty.opptyId               = o["OpptyID"]
      @oppty.opptyName             = o["OpptyName"]
      @oppty.idiqCA                = o["IDIQ_CA"]
      @oppty.status2               = o["Status2"]
      @oppty.value                 = o["Total Value $M"]
      @oppty.pWin                  = o["pWin"]
      @oppty.captureMgr            = o["Capturemgr"]
      @oppty.programMgr            = o["ProgramMgr"]
      @oppty.proposalMgr           = o["ProposalMgr"]
      @oppty.technicalLead         = o["TechnicalLead"]
      @oppty.slArch                = o["SLArch"]
      @oppty.slComments            = o["SL Comments"]
      @oppty.rfpDate               = Date.new(1899,12,30) + o["RFPDate"].to_f
      @oppty.awardDate             = Date.new(1899,12,30) + o["AwardDate"].to_f
      @oppty.slDir                 = o["SLDir"]
      @oppty.leadEstim             = o["LeadEstim"]
      @oppty.engaged               = o["Engaged r/y/g"]
      @oppty.solution              = o["Solution r/y/g"]
      @oppty.estimate              = o["Estimate r/y/g"]
      @oppty.proposalDueDate       = Date.new(1899,12,30) + o["ProposalDueDate"].to_f
      @oppty.codeName              = o["CodeName"]
      @oppty.descriptionOfWork     = o["DescriptionOfWork"]
      @oppty.category              = o["Category"]
      @oppty.pwald                 = o["PWALD"]
      @oppty.pBid                  = o["pBid"]
      @oppty.awardFV               = o["AwardFV"]
      @oppty.saicvaPercent         = o["SAICVA%"]
      @oppty.saicva                = o["SAIC VA $M"]
      @oppty.mat                   = o["Mat%"]
      @oppty.materialsTV           = o["Mat TV $M"]
      @oppty.subc                  = o["Subc%"]
      @oppty.subTV                 = o["Subc TV $M"]
      @oppty.cg_va                 = o["CG_VA"]
      @oppty.sss_va                = o["SSS-3621"] # i have no idea why
      @oppty.nwi_va                = o["NWI-3933"]
      @oppty.hwi_va                = o["HWI-3648"]
      @oppty.itms_va               = o["ITMS-3896"]
      @oppty.tss_va                = o["TSS-3676"]
      @oppty.ccds_va               = o["CCDS-3932"]
      @oppty.mss_va                = o["MSS-3690"]
      @oppty.swi_va                = o["SWI-3934"]
      @oppty.lsc_va                = o["LSC-3640"]
      @oppty.zzOth_va              = o["zzOth_VA"]
      @oppty.pri                   = o["Pri"]
      @oppty.aop                   = o["AOP"]
      @oppty.peg                   = o["PEG"]
      @oppty.mustWin               = o["MustWin"]
      @oppty.feeIndic              = o["FeeIndic"]
      @oppty.slutil                = o["Slutil"]
      @oppty.recompete             = o["Recompete"]
      @oppty.competitive           = o["Competitive"]
      @oppty.international         = o["International"]
      @oppty.strategic             = o["Strategic"]
      @oppty.bundle                = o["Bundle"]
      @oppty.bidReviewStream       = o["BidReviewStream"]
      @oppty.definedDelivPgm       = o["DefinedDelivPgm"]
      @oppty.evaluationCriteria    = o["EvaluationCriteria"]
      @oppty.perfWorkLoc           = o["PerfWorkLoc"]
      @oppty.classIfReqmt          = o["ClassifReqmt"]
      @oppty.grouping              = o["Grouping"]
      @oppty.reasonForWinLoss      = o["ReasonforWinLoss"]
      @oppty.egr                   = o["EGR"]
      @oppty.slCat                 = o["SLcat"]
      @oppty.slPri                 = o["Slpri"]
      @oppty.slNote                = o["Slnote"]
      @oppty.crmRunDate            = o["CRMRunDate"]
      @oppty.contractStartDate     = o["ContractStartDate"]
      @oppty.rfpFYPer              = o["RFPFYPer"]
      @oppty.submitFYPer           = o["SubmitFYPer"]
      @oppty.awardFYPer            = o["AwardFYPer"]
      @oppty.preBPprojID           = o["PreBPprojID"]
      @oppty.fy16PreBP             = o["FY16 PreB&P$"]
      @oppty.fy16PreBPSpent        = o["FY16 PreB&P $Spent"]
      @oppty.fy16PreBPSpentPercent = o["FY16 PreB&P %Spent"]
      @oppty.bpProjID              = o["BPprojID"]
      @oppty.fy16BDTot             = o["FY16 BDTot$"]
      @oppty.fy16BDTotSpent        = o["FY16 BDTot $Spent"]
      @oppty.fy16BDTotSpentPercent = o["FY16 BDTot %Spent"]
      @oppty.financeDate           = o["FinDate"]
      @oppty.cgSecOrg              = o["SecOrg"]
      @oppty.cgSecMgr              = o["SecMgr"]
      @oppty.cgOrg                 = o["CGOrg"]
      @oppty.cgMgr                 = o["CGMgr"]
      @oppty.opOrg                 = o["OpOrg"]
      @oppty.cgOpMgr               = o["OpMgr"]
      @oppty.cgPgmDir              = o["PgmDir"]
      @oppty.bdMgr                 = o["BDMgr"]
      @oppty.crmRecOwner           = o["CRMRecOwner"]
      @oppty.sslMgr                = o["SSLeadMgr"]
      @oppty.divNum                = o["DivNum"]
      @oppty.customer              = o["Customer"]
      @oppty.endCustomer           = o["EndCustomer"]
      @oppty.crn                   = o["CRN"]
      @oppty.contractType          = o["ContractType"]
      @oppty.opptyClass            = o["OpptyClass"]
      @oppty.numberOfAwards        = o["NumberOfAwards"]
      @oppty.totalPOP              = o["TotalPOP"]
      @oppty.primeSub              = o["PrimeSub"]
      @oppty.fy16BP                = o["FY16 B&P$"]
      @oppty.fy16BPSpent           = o["FY16 B&P $Spent"]
      @oppty.fy16BPSpentPercent    = o["FY16 B&P %Spent"]
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
    data.each do |o|
      uploadedIds.push(o["OpptyID"])
      #if there is some magical ruby way to do this better, please do it. I don't know ruby :(
      #quite possibly the hackiest code in this project
      #######################get values from json##########################
      id                    = o["OpptyID"]
      name                  = o["OpptyName"]
      idiqCA                = o["IDIQ_CA"]
      status2               = o["Status2"]
      value                 = o["Total Value $M"]
      pWin                  = o["pWin"]
      captureMgr            = o["Capturemgr"]
      programMgr            = o["ProgramMgr"]
      proposalMgr           = o["ProposalMgr"]
      technicalLead         = o["TechnicalLead"]
      slArch                = o["SLArch"]
      slComments            = o["SL Comments"]
      rfpDate               = Date.new(1899,12,30) + o["RFPDate"].to_f
      awardDate             = Date.new(1899,12,30) + o["AwardDate"].to_f
      slDir                 = o["SLDir"]
      leadEstim             = o["LeadEstim"]
      engaged               = o["Engaged r/y/g"]
      solution              = o["Solution r/y/g"]
      estimate              = o["Estimate r/y/g"]
      proposalDueDate       = Date.new(1899,12,30) + o["ProposalDueDate"].to_f
      codeName              = o["CodeName"]
      descriptionOfWork     = o["DescriptionOfWork"]
      category              = o["Category"]
      pwald                 = o["PWALD"]
      pBid                  = o["pBid"]
      awardFV               = o["AwardFV"]
      saicvaPercent         = o["SAICVA%"]
      saicva                = o["SAIC VA $M"]
      mat                   = o["Mat%"]
      materialsTV           = o["Mat TV $M"]
      subc                  = o["Subc%"]
      subTV                 = o["Subc TV $M"]
      cg_va                 = o["CG_VA"]
      sss_va                = o["SSS-3621"] # i have no idea why
      nwi_va                = o["NWI-3933"]
      hwi_va                = o["HWI-3648"]
      itms_va               = o["ITMS-3896"]
      tss_va                = o["TSS-3676"]
      ccds_va               = o["CCDS-3932"]
      mss_va                = o["MSS-3690"]
      swi_va                = o["SWI-3934"]
      lsc_va                = o["LSC-3640"]
      zzOth_va              = o["zzOth_VA"]
      pri                   = o["Pri"]
      aop                   = o["AOP"]
      peg                   = o["PEG"]
      mustWin               = o["MustWin"]
      feeIndic              = o["FeeIndic"]
      slutil                = o["Slutil"]
      recompete             = o["Recompete"]
      competitive           = o["Competitive"]
      international         = o["International"]
      strategic             = o["Strategic"]
      bundle                = o["Bundle"]
      bidReviewStream       = o["BidReviewStream"]
      definedDelivPgm       = o["DefinedDelivPgm"]
      evaluationCriteria    = o["EvaluationCriteria"]
      perfWorkLoc           = o["PerfWorkLoc"]
      classIfReqmt          = o["ClassifReqmt"]
      grouping              = o["Grouping"]
      reasonForWinLoss      = o["ReasonforWinLoss"]
      egr                   = o["EGR"]
      slCat                 = o["SLcat"]
      slPri                 = o["Slpri"]
      slNote                = o["Slnote"]
      crmRunDate            = o["CRMRunDate"]
      contractStartDate     = o["ContractStartDate"]
      rfpFYPer              = o["RFPFYPer"]
      submitFYPer           = o["SubmitFYPer"]
      awardFYPer            = o["AwardFYPer"]
      preBPprojID           = o["PreBPprojID"]
      fy16PreBP             = o["FY16 PreB&P$"]
      fy16PreBPSpent        = o["FY16 PreB&P $Spent"]
      fy16PreBPSpentPercent = o["FY16 PreB&P %Spent"]
      bpProjID              = o["BPprojID"]
      fy16BDTot             = o["FY16 BDTot$"]
      fy16BDTotSpent        = o["FY16 BDTot $Spent"]
      fy16BDTotSpentPercent = o["FY16 BDTot %Spent"]
      financeDate           = o["FinDate"]
      cgSecOrg              = o["SecOrg"]
      cgSecMgr              = o["SecMgr"]
      cgOrg                 = o["CGOrg"]
      cgMgr                 = o["CGMgr"]
      opOrg                 = o["OpOrg"]
      cgOpMgr               = o["OpMgr"]
      cgPgmDir              = o["PgmDir"]
      bdMgr                 = o["BDMgr"]
      crmRecOwner           = o["CRMRecOwner"]
      sslMgr                = o["SSLeadMgr"]
      divNum                = o["DivNum"]
      customer              = o["Customer"]
      endCustomer           = o["EndCustomer"]
      crn                   = o["CRN"]
      contractType          = o["ContractType"]
      opptyClass            = o["OpptyClass"]
      numberOfAwards        = o["NumberOfAwards"]
      totalPOP              = o["TotalPOP"]
      primeSub              = o["PrimeSub"]
      fy16BP                = o["FY16 B&P$"]
      fy16BPSpent           = o["FY16 B&P $Spent"]
      fy16BPSpentPercent    = o["FY16 B&P %Spent"]
      ####################################################################
      if data = Oppty.find_by(opptyId:id)
        diff = Hash.new
        diff.default = 0
        change = false

      # if the cell changed, hashtable contains the new value and ID
        if name              != data.opptyName
          diff["opptyName"]        = name
          change = true end
        if idiqCA            != data.idiqCA
          diff["idiqCA"]           = idiqCA
          change = true end
        if status2           != data.status2
          diff["status2"]          = status2
          change = true end
        if value             != data.value
          diff["value"]            = value
          change = true end
        #########Potential loating point inaccuracies, however per we believe this is inconsequential ###########
        if pWin             != data.pWin
          diff["pWin"]            = pWin
          change = true end
        if captureMgr        != data.captureMgr
          diff["captureMgr"]       = captureMgr
          change = true end
        if programMgr        != data.programMgr
          diff["programMgr"]       = programMgr
          change = true end
        if proposalMgr       != data.proposalMgr
          diff["proposalMgr"]      = proposalMgr
          change = true end
        if technicalLead     != data.technicalLead
          diff["technicalLead"]    = technicalLead
          change = true end
        if slArch            != data.slArch
          diff["slArch"]           = slArch
          change = true end
        if slComments        != data.slComments
          diff["slComments"]       = slComments
          change = true end
        if rfpDate           != data.rfpDate
          diff["rfpDate"]          = rfpDate
          change = true end
        if awardDate         != data.awardDate
          diff["awardDate"]        = awardDate
          change = true end
        if slDir             != data.slDir
          diff["slDir"]            = slDir
          change = true end
        if leadEstim         != data.leadEstim
          diff["leadEstim"]        = leadEstim
          change = true end
        if engaged           != data.engaged
          diff["engaged"]          = engaged
          change = true end
        if solution          != data.solution
          diff["solution"]         = solution
          change = true end
        if estimate          != data.estimate
          diff["estimate"]         = estimate
          change = true end
        if proposalDueDate   != data.proposalDueDate
          diff["proposalDueDate"]  = proposalDueDate
          change = true end
        if codeName   != data.codeName
          diff["codeName"]  = codeName
          change = true end
        if descriptionOfWork   != data.descriptionOfWork
          diff["descriptionOfWork"]  = descriptionOfWork
          change = true end
        if category   != data.category
          diff["category"]  = category
          change = true end
        if pwald   != data.pwald
          diff["pwald"]  = pwald
          change = true end
        if pBid   != data.pBid
          diff["pBid"]  = pBid
          change = true end
        if awardFV   != data.awardFV
          diff["awardFV"]  = awardFV
          change = true end
        if saicvaPercent   != data.saicvaPercent
          diff["saicvaPercent"]  = saicvaPercent
          change = true end
        if mat   != data.mat
          diff["mat"]  = mat
          change = true end
        if materialsTV   != data.materialsTV
          diff["materialsTV"]  = materialsTV
          change = true end
        if subc   != data.subc
          diff["subc"]  = subc
          change = true end
        if subTV   != data.subTV
          diff["subTV"]  = subTV
          change = true end
        if cg_va   != data.cg_va
          diff["cg_va"]  = cg_va
          change = true end
        if sss_va   != data.sss_va
          diff["sss_va"]  = sss_va
          change = true end
        if nwi_va   != data.nwi_va
          diff["nwi_va"]  = nwi_va
          change = true end
        if hwi_va   != data.hwi_va
          diff["hwi_va"]  = hwi_va
          change = true end
        if itms_va   != data.itms_va
          diff["itms_va"]  = itms_va
          change = true end
        if tss_va   != data.tss_va
          diff["tss_va"]  = tss_va
          change = true end
        if ccds_va   != data.ccds_va
          diff["ccds_va"]  = ccds_va
          change = true end
        if mss_va   != data.mss_va
          diff["mss_va"]  = mss_va
          change = true end
        if swi_va   != data.swi_va
          diff["swi_va"]  = swi_va
          change = true end
        if lsc_va   != data.lsc_va
          diff["lsc_va"]  = lsc_va
          change = true end
        if zzOth_va   != data.zzOth_va
          diff["zzOth_va"]  = zzOth_va
          change = true end
        if pri   != data.pri
          diff["pri"]  = pri
          change = true end
        if aop   != data.aop
          diff["aop"]  = aop
          change = true end
        if peg   != data.peg
          diff["peg"]  = peg
          change = true end
        if mustWin   != data.mustWin
          diff["mustWin"]  = mustWin
          change = true end
        if feeIndic   != data.feeIndic
          diff["feeIndic"]  = feeIndic
          change = true end
        if slutil   != data.slutil
          diff["slutil"]  = slutil
          change = true end
        if recompete   != data.recompete
          diff["recompete"]  = recompete
          change = true end
        if competitive   != data.competitive
          diff["competitive"]  = competitive
          change = true end
        if international   != data.international
          diff["international"]  = international
          change = true end
        if strategic   != data.strategic
          diff["strategic"]  = strategic
          change = true end
        if bundle   != data.bundle
          diff["bundle"]  = bundle
          change = true end
        if bidReviewStream   != data.bidReviewStream
          diff["bidReviewStream"]  = bidReviewStream
          change = true end
        if definedDelivPgm   != data.definedDelivPgm
          diff["definedDelivPgm"]  = definedDelivPgm
          change = true end
        if evaluationCriteria   != data.evaluationCriteria
          diff["evaluationCriteria"]  = evaluationCriteria
          change = true end
        if perfWorkLoc   != data.perfWorkLoc
          diff["perfWorkLoc"]  = perfWorkLoc
          change = true end
        if classIfReqmt   != data.classIfReqmt
          diff["classIfReqmt"]  = classIfReqmt
          change = true end
        if grouping   != data.grouping
          diff["grouping"]  = grouping
          change = true end
        if reasonForWinLoss   != data.reasonForWinLoss
          diff["reasonForWinLoss"]  = reasonForWinLoss
          change = true end
        if egr   != data.egr
          diff["egr"]  = egr
          change = true end
        if slCat   != data.slCat
          diff["slCat"]  = slCat
          change = true end
        if slPri   != data.slPri
          diff["slPri"]  = slPri
          change = true end
        if slNote   != data.slNote
          diff["slNote"]  = slNote
          change = true end
        if crmRunDate   != data.crmRunDate
          diff["crmRunDate"]  = crmRunDate
          change = true end
        if contractStartDate   != data.contractStartDate
          diff["contractStartDate"]  = contractStartDate
          change = true end
        if rfpFYPer   != data.rfpFYPer
          diff["rfpFYPer"]  = rfpFYPer
          change = true end
        if submitFYPer   != data.submitFYPer
          diff["submitFYPer"]  = submitFYPer
          change = true end
        if awardFYPer   != data.awardFYPer
          diff["awardFYPer"]  = awardFYPer
          change = true end
        if preBPprojID   != data.preBPprojID
          diff["preBPprojID"]  = preBPprojID
          change = true end
        if fy16PreBP   != data.fy16PreBP
          diff["fy16PreBP"]  = fy16PreBP
          change = true end
        if fy16PreBPSpent   != data.fy16PreBPSpent
          diff["fy16PreBPSpent"]  = fy16PreBPSpent
          change = true end
        # for some reason this sometimes has the value "0Budget" which can be seen in the excelsheet
        # if fy16PreBPSpentPercent   != data.fy16PreBPSpentPercent
        #   diff["fy16PreBPSpentPercent"]  = fy16PreBPSpentPercent
        #   change = true end
        if bpProjID   != data.bpProjID
          diff["bpProjID"]  = bpProjID
          change = true end
        if fy16BDTot   != data.fy16BDTot
          diff["fy16BDTot"]  = fy16BDTot
          change = true end
        if fy16BDTotSpent   != data.fy16BDTotSpent
          diff["fy16BDTotSpent"]  = fy16BDTotSpent
          change = true end
        # "0Budget" issue
        # if fy16BDTotSpentPercent   != data.fy16BDTotSpentPercent
        #   diff["fy16BDTotSpentPercent"]  = fy16BDTotSpentPercent
        #   change = true end
        if financeDate   != data.financeDate
          diff["financeDate"]  = financeDate
          change = true end
        if cgSecOrg   != data.cgSecOrg
          diff["cgSecOrg"]  = cgSecOrg
          change = true end
        if cgSecMgr   != data.cgSecMgr
          diff["cgSecMgr"]  = cgSecMgr
          change = true end
        if cgOrg   != data.cgOrg
          diff["cgOrg"]  = cgOrg
          change = true end
        if cgMgr   != data.cgMgr
          diff["cgMgr"]  = cgMgr
          change = true end
        if opOrg   != data.opOrg
          diff["opOrg"]  = opOrg
          change = true end
        if cgOpMgr   != data.cgOpMgr
          diff["cgOpMgr"]  = cgOpMgr
          change = true end
        if cgPgmDir   != data.cgPgmDir
          diff["cgPgmDir"]  = cgPgmDir
          change = true end
        if bdMgr   != data.bdMgr
          diff["bdMgr"]  = bdMgr
          change = true end
        if crmRecOwner   != data.crmRecOwner
          diff["crmRecOwner"]  = crmRecOwner
          change = true end
        if sslMgr   != data.sslMgr
          diff["sslMgr"]  = sslMgr
          change = true end
        if divNum   != data.divNum
          diff["divNum"]  = divNum
          change = true end
        if customer   != data.customer
          diff["customer"]  = customer
          change = true end
        if endCustomer   != data.endCustomer
          diff["endCustomer"]  = endCustomer
          change = true end
        if crn   != data.crn
          diff["crn"]  = crn
          change = true end
        if contractType   != data.contractType
          diff["contractType"]  = contractType
          change = true end
        if opptyClass   != data.opptyClass
          diff["opptyClass"]  = opptyClass
          change = true end
        if numberOfAwards   != data.numberOfAwards
          diff["numberOfAwards"]  = numberOfAwards
          change = true end
        if totalPOP   != data.totalPOP
          diff["totalPOP"]  = totalPOP
          change = true end
        if primeSub   != data.primeSub
          diff["primeSub"]  = primeSub
          change = true end
        if fy16BP   != data.fy16BP
          diff["fy16BP"]  = fy16BP
          change = true end
        if fy16BPSpent   != data.fy16BPSpent
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
              to_push = true
              #break
            end
          end
          if to_push == true
            diff["opptyId"] = id
            @changes.push(diff) # add hash to list
          end
        end
      else
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
        @name = @download_path.gsub("new_", "")
        puts "*"*30
        puts @name
        puts @download_path
        puts "*"*30
        File.rename @download_path, @name
        file = File.open(@name, "rb")
        contents = file.read
        file.close
        File.rename @name, @download_path
        send_data(contents, :filename =>File.basename( @name))
    else
        redirect_to crm_index_path
    end
  end
end
