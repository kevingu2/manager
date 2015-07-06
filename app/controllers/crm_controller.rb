class CrmController < ApplicationController
  CRM_PATH = File.join("public", "uploads", "test.txt")
  def index
  end

  def upload
    uploaded_io = params[:upl]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    #test=`python Rails.root.join('bin','test.py')`
    #puts test
    redirect_to invalid_entry_index_path, notice: "File uploaded"
  end

  def download
    send_file CRM_PATH, :filename =>'test.txt', :type=>"text", :x_sendfile=>true
  end

end
