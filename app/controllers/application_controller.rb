class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	helper_method :current_user
	
	def log_in(user)
		session[:user_id] = user.id
		user.remember_token = user.new_token
		cookies.permanent[:remember_token] = user.remember_token
	end

	def sign_out
		@current_user = nil
  		cookies.signed[:remember_token] = nil
  		session.clear
  		redirect_to login_url
	end

	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		elsif cookies.signed[:remember_token]
			hash = Digest::SHA1.hexdigest(cookies.signed[:remember_token].to_s)
			current_user ||= User.find_by(hash)
		else
			nil
		end
	end

	def current_user=(user)
		@current_user = user
	end

end
