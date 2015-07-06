class UploadCrmController < ApplicationController
  def index
    #Code for running python script
    #test=`python Rails.root.join('bin','test.py')`
    #puts "TEST Python script"
    #puts test
  end

  def upload
    uploaded_io = params[:upl]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    #test=`python Rails.root.join('bin','test.py')`
    #puts "TEST Python script"
    #puts test
    redirect_to invalid_entry_index_path, notice: "File uploaded"
  end

end
