class StubsController < ApplicationController
	before_action :set_project
	before_action :set_stub, only: [:show, :edit, :update, :destroy]

	def new
		@stub = @project.stubs.build
		authorize @stub, :create?
	end

	def create
		@stub = @project.stubs.build(stub_params)
		@stub.author = current_user
		authorize @stub, :create?
		
		if @stub.save
			flash[:notice] = "Stub has been created."
			redirect_to [@project, @stub]
		else
			flash.now[:alert] = "Stub has not been created."
			render "new"
		end
	end 

	def show
		authorize @stub, :show?
	end

	def edit 
		authorize @stub, :update?
	end

	def update
		authorize @stub, :update?
		
		if @stub.update(stub_params)
			flash[:notice] = "Stub has been updated"
			redirect_to [@project, @ticket]
		else
			flash.now[:alert] = "Stub has not been updated"
			render "edit"
		end
	end

	def destroy 
		authorize @stub, :destroy?
		@stub.destroy
		flash[:notice] = "Stub has been deleted"
		redirect_to @project 
	end

	private

	def set_stub
		@stub = @project.stubs.find(params[:id])
	end

	def stub_params
		params.require(:stub).permit(:name, :desription, :attachment, :attachment_cache)
	end

	def set_project
		@project = Project.find(params[:project_id])
	end
end
