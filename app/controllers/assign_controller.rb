class AssignController < ApplicationController
  def index
    @opptyId=params[:opptyId]
    @writers=User.where(role:"writer")

  end
end
