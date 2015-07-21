class AllocatedTasksController < ApplicationController
	def index
    @not_accepted=[]
    @todo=[]
    @doing=[]
    @done=[]
    Oppty.all.each do |o|
      puts "Count: "+o.user_oppties.count.to_s
      o.user_oppties.each do|uo|

      end

    end

  end

end
