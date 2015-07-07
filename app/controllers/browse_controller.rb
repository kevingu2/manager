class BrowseController < ApplicationController
  def index
    @oppties = Oppty.all
  end
end
