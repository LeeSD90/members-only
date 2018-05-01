class PostsController < ApplicationController
	before_action	:logged_in?, :only => [:new, :create]

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(title: params[:post][:title], content: params[:post][:content], user_id: current_user.id)
		if @post.save
			redirect_to posts_path
		else
			flash.now[:danger] = "Couldn't save post!"
  			render 'new'
  		end
	end

	def index
		@posts = Post.all
	end

end
