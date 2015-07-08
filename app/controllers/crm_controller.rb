class CrmController < ApplicationController
  CRM_PATH = File.join(Rails.root, "public", "uploads")
  def index
    @oppty = Oppty.all
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
        change = false

      # if the cell changed, hashtable contains the new value and ID
        if name             != data.opptyName
          diff["opptyName"]        = name
          change = true end
        if idiqCA           != data.idiqCA
          diff["idiqCA"]           = idiqCA
          change = true end
        if status2          != data.status2
          diff["status2"]          = status2
          change = true end
        if value            != data.value
          diff["value"]            = value
          change = true end
        # if pWin             != data.pWin
        #   diff["pWin"]             = pWin
        #   change = true end
        if captureMgr       != data.captureMgr
          diff["captureMgr"]       = captureMgr
          change = true end
        if programMgr       != data.programMgr
          diff["programMgr"]       = programMgr
          change = true end
        if proposalMgr      != data.proposalMgr
          diff["proposalMgr"]      = proposalMgr
          change = true end
        if technicalLead    != data.technicalLead
          diff["technicalLead"]    = technicalLead
          change = true end
        if sslArch          != data.sslArch
          diff["sslArch"]          = sslArch
          change = true end
        if slComments       != data.slComments
          diff["slComments"]       = slComments
          change = true end
        if rfpDate          != data.rfpDate
          diff["rfpDate"]          = rfpDate
          change = true end
        if awardDate        != data.awardDate
          diff["awardDate"]        = awardDate
          change = true end
        if slDir            != data.slDir
          diff["slDir"]            = slDir
          change = true end
        if leadEstim        != data.leadEstim
          diff["leadEstim"]        = leadEstim
          change = true end
        if engaged          != data.engaged
          diff["engaged"]          = engaged
          change = true end
        if solution         != data.solution
          diff["solution"]         = solution
          change = true end
        if estimate         != data.estimate
          diff["estimate"]         = estimate
          change = true end
        if proposalDueDate  != data.proposalDueDate
          diff["proposalDueDate"]  = proposalDueDate
          change = true end
        if change == true
          diff["opptyId"] = id
          @changes.push(diff) # add hash to list
        end
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
    puts @changes.length
    redirect_to crm_upload_path(:changes => @changes)
    #redirect_to invalid_entry_index_path, notice: "File uploaded"
    #redirect_to crm_index_path(:changes => @changes)
  end

  #downloading the modified excel file from the browser
  def download
    send_file CRM_PATH, :type=>"application/txt", :x_sendfile=>true
  end

end
