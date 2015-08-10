class SessionsController < ApplicationController
	skip_before_action :authorize , only: [:destroy,:new, :create]
	def new
		#redirect_to root_path if current_user
	end

	def create
		ldap_user = Adauth.authenticate(params[:username], params[:password])
		if ldap_user
			puts '----- user authenticated -----'
        	user = User.return_and_create_from_adauth(ldap_user)
        	session[:user_id] = user.id
        	redirect_to allocated_tasks_index_path
    	else
    		puts '----- user not authenticated -----'
        	redirect_to brow_index_path
    	end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end