class BrowseController < ApplicationController
  def index
    #system call to run python script
    @oppties = Oppty.all
  end
end
