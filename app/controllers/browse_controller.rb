#accessing all opportunities and saving it in oppties variable for use in html

class BrowseController < ApplicationController
  def index
    @oppties = Oppty.all
  end
end
