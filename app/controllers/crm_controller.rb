class CrmController < ApplicationController
  CRM_PATH = File.join(Rails.root, "public", "uploads")
  def index
  end

  #uploading an excel file from user's computer
  def upload
    uploaded_io = params[:upl]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    fileName = uploaded_io.original_filename.to_s
    data = `python bin/excelReader.py "public/uploads/#{fileName}"`
    data = JSON.parse(data)
    @changes = [] # holds list of hashes that contain what is changed
    data.each do |o|
      #if there is some magical ruby way to do this better, please do it. I don't know ruby :(
      #quite possibly the hackiest code in this project
      #######################get values from json##########################
      id                   = o["OpptyID"]
      name                 = o["OpptyName"]
      idiqCA               = o["IDIQ_CA"]
      status2              = o["Status2"]
      value                = o["Total Value $M"]
      pWin                 = o["pWin"]
      captureMgr           = o["Capturemgr"]
      programMgr           = o["ProgramMgr"]
      proposalMgr          = o["ProposalMgr"]
      technicalLead        = o["TechnicalLead"]
      sslArch              = o["SLArch"]
      slComments           = o["SL Comments"]
      rfpDate              = Date.new(1899,12,30) + o["RFPDate"].to_f
      awardDate            = Date.new(1899,12,30) + o["AwardDate"].to_f
      slDir                = o["SLDir"]
      leadEstim            = o["LeadEstim"]
      engaged              = o["Engaged r/y/g"]
      solution             = o["Solution r/y/g"]
      estimate             = o["Estimate r/y/g"]
      proposalDueDate      = Date.new(1899,12,30) + o["ProposalDueDate"].to_f
      ####################################################################
      if data = Oppty.find_by(opptyId:id)
        diff = Hash.new
        diff.default = 0
        diff["opptyId"] = id
      # if the value is 1, then it changed
        if name             != data.opptyName       then diff["opptyName"]        = 1 end
        if idiqCA           != data.idiqCA          then diff["idiqCA"]           = 1 end
        if status2          != data.status2         then diff["status2"]          = 1 end
        if value            != data.value           then diff["value"]            = 1 end
        if pWin             != data.pWin            then diff["pWin"]             = 1 end
        if captureMgr       != data.captureMgr      then diff["captureMgr"]       = 1 end
        if programMgr       != data.programMgr      then diff["programMgr"]       = 1 end
        if proposalMgr      != data.proposalMgr     then diff["proposalMgr"]      = 1 end
        if technicalLead    != data.technicalLead   then diff["technicalLead"]    = 1 end
        if sslArch          != data.sslArch         then diff["sslArch"]          = 1 end
        if slComments       != data.slComments      then diff["slComments"]       = 1 end
        if rfpDate          != data.rfpDate         then diff["rfpDate"]          = 1 end
        if awardDate        != data.awardDate       then diff["awardDate"]        = 1 end
        if slDir            != data.slDir           then diff["slDir"]            = 1 end
        if leadEstim        != data.leadEstim       then diff["leadEstim"]        = 1 end
        if engaged          != data.engaged         then diff["engaged"]          = 1 end
        if solution         != data.solution        then diff["solution"]         = 1 end
        if estimate         != data.estimate        then diff["estimate"]         = 1 end
        if proposalDueDate  != data.proposalDueDate then diff["proposalDueDate"]  = 1 end
        @changes.push(diff) # add hash to list
      else
        @oppty=Oppty.new
        #fields
        @oppty.opptyId          = id
        @oppty.opptyName        = name
        @oppty.idiqCA           = idiqCA
        @oppty.status2          = status2
        @oppty.value            = value
        @oppty.pWin             = pWin
        @oppty.captureMgr       = captureMgr
        @oppty.programMgr       = programMgr
        @oppty.proposalMgr      = proposalMgr
        @oppty.technicalLead    = technicalLead
        @oppty.sslArch          = sslArch
        @oppty.slComments       = slComments
        @oppty.rfpDate          = rfpDate
        @oppty.awardDate        = awardDate
        @oppty.slDir            = slDir
        @oppty.leadEstim        = leadEstim
        @oppty.engaged          = engaged
        @oppty.solution         = solution
        @oppty.estimate         = estimate
        @oppty.proposalDueDate  = proposalDueDate
        @oppty.save
      end
    end
    redirect_to invalid_entry_index_path, notice: "File uploaded"
  end

  #downloading the modified excel file from the browser
  def download
    send_file CRM_PATH, :filename =>'test.txt', :type=>"application/txt", :x_sendfile=>true
  end

end
