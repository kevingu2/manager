class InvalidDataController < ApplicationController
  def index
    @invalid_data=Oppty.where("rfpDate<?", Date.today.to_s)
  end
end
