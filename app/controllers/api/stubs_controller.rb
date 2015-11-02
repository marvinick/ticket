class API::StubsController < ApplicationController
	attr_reader :current_user
	before_action :set_project
	before_action :authenticate_user

	def show 
		@stub = @project.stubs.find(params[:id])
		authorize @stub, :show?
		render json: @stub 
	end

	private 
	
	def authenticate_user
		authenticate_with_http_token do |token| 
			@current_user = User.find_by(api_key: token)
		end
	end

	def set_project
		@project = Project.find(params[:project_id])
	end

end
