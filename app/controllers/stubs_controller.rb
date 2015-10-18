class StubsController < ApplicationController
	before_action :set_project

	def new
		@stub = @project.stubs.build
	end

	private 

	def set_project
		@project = Project.find(params[:project_id])
	end
end
