class UploadCrmController < ApplicationController
  def index
    #Code for running pyhton script
    #test=`python Rails.root.join('bin','test.py')`
    #puts "TEST Python script"
    #puts test
  end

  def upload
    uploaded_io = params[:upl]
    print "UPLoading"
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    redirect_to invalid_entry_index_path, notice: "File uploaded"
  end

end
