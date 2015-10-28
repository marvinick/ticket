class StubsController < ApplicationController
	before_action :set_project
	before_action :set_stub, only: [:show, :edit, :update, :destroy]

	def new
		@stub = @project.stubs.build
		authorize @stub, :create?
	  @stub.attachments.build 
	end

	def create
		@stub = @project.stubs.new

		whitelisted_params = stub_params
		unless policy(@stub).tag?
			whitelisted_params.delete(:tag_names)
		end

		@stub.attributes = whitelisted_params
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
		@comment = @stub.comments.build(state_id: @stub.state_id)
	end

	def search 
		authorize @project, :show?
		if params[:search].present?
			@stubs = @project.stubs.search(params[:search])
		else
			@stubs = @project.stubs
		end
		render "projects/show"
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
		params.require(:stub).permit(:name, :desription, :tag_names, attachments_attributes: [:file, :file_cache])
	end

	def set_project
		@project = Project.find(params[:project_id])
	end
end
