class AssignController < ApplicationController
  def index
    @opptyId=params[:opptyId]
    #@writers=UserOppty.where(oppty_id: params[:opptyId]).where(role:"writer").where()
  end
end
