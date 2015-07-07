# TO DO:
#   Fix the Download button on line 39

#uploading the crm (excel file)
#also allows for downloading the modified excel file

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
    data.each do |o|
      #puts o
      #puts "************************************************"
      @oppty=Oppty.new
      # @oppty.opptyId    = o["OpptyID"]
      
      #fields
      @oppty.opptyName  = o["OpptyName"]
      @oppty.idiqCA     = o["IDIQ_CA"]
      @oppty.status2    = o["Status2"]
      @oppty.value      = o["Total Value $M"]
      @oppty.pWin       = o["pWin"]
      @oppty.captureMgr = o["CaptureMgr"]
      @oppty.programMgr = o["ProgramMgr"]
      @oppty.proposalMgr= o["ProposalMgr"]
      #@oppty.sslOgr     = o["SLLOrg"]
      @oppty.technicalLead = o["TechnicalLead"]
      @oppty.sslArch = o["SLArch"]
      @oppty.slComments = o["SL Comments"]
      @oppty.rfpDate = DateTime.new(1899,12,30) + o["RFPDate"].to_f
      @oppty.awardDate = DateTime.new(1899,12,30) + o["AwardDate"].to_f
      @oppty.save
    end
    redirect_to invalid_entry_index_path, notice: "File uploaded"
  end
  
  #downloading the modified excel file from the browser
  def download
    send_file CRM_PATH, :filename =>'test.txt', :type=>"application/txt", :x_sendfile=>true
  end

end
