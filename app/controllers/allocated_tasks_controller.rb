class AllocatedTasksController < ApplicationController
	def index
    todo_writer=UserOppty.where(status: 2).joins('join (select * from users where role="writer")u
                                      on user_oppties.user_id=u.id').includes(:user, :oppty)
    doing_writer=UserOppty.where(status: 1).joins('join (select * from users where role="writer")u
                                      on user_oppties.user_id=u.id').includes(:user, :oppty)
    done_writer=UserOppty.where(status: 1).joins('join (select * from users where role="writer")u
                                      on user_oppties.user_id=u.id').includes(:user, :oppty)
    @todo_writer_dict={}
    @doing_writer_dict={}
    @done_writer_dict={}

    users=User.all
    @name_dict={}
    users.each do|u|
      if(u.role!="manager")
        @name_dict[u.id]=u.name
      end
    end

    todo_writer.each do |o|
      if(@todo_writer_dict.has_key?(o.user.id))
        @todo_writer_dict[o.user.id].push(o)
      else
        @todo_writer_dict[o.user.id]=[o]
      end
    end
    doing_writer.each do |o|
      if(@doing_writer_dict.has_key?(o.user.id))
        @doing_writer_dict[o.user.id].push(o)
      else
        @doing_writer_dict[o.user.id]=[o]
      end
    end
    done_writer.each do |o|
      if(@done_writer_dict.has_key?(o.user.id))
        @done_writer_dict[o.user.id].push(o)
      else
        @done_writer_dict[o.user.id]=[o]
      end
    end
  end

end
