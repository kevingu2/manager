class AllocatedTasksController < ApplicationController
	def index
    @not_accepted=[]
    @todo=[]
    @doing=[]
    @done=[]
    Oppty.all.each do |o|
      puts "Count: "+o.user_oppties.count.to_s
      o.user_oppties.each do|uo|
        if uo.status==1
          @doing.put(o)
          break
        end
        if uo.status==2
          @todo.put(o)
          break
        end
        if uo.status==3

        end
      end
    end

  end

end
