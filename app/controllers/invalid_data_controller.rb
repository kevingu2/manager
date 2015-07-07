class InvalidDataController < ApplicationController
  def index
    @invalid_data=Oppty.where("done==? and rfpDate<?",false, Date.today.to_s)
    puts 'Invalid Date'+@invalid_data.to_s
  end
end
