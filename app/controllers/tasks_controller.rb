class TasksController < ApplicationController
  def index
    @oppties=UserOppty.where(user_id:session[:user_id]).joins(:oppty).includes(:oppty)
    puts "QUERY"
    puts @oppties
    @oppties.each do |o|
      puts o.oppty.opptyName
    end
  end
end
