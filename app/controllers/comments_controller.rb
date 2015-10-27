class CommentsController < ApplicationController
	before_action :set_stub

	def create 
		whitelisted_params = comment_params

		unless policy(@stub).change_state?
			whitelisted_params.delete(:state_id)
		end

		@comment = @stub.comments.build(whitelisted_params)
		@comment.author = current_user
		authorize @comment, :create?
	
		if @comment.save
			flash[:notice] = "Comment has been created."
			redirect_to [@stub.project, @stub]
		else
			flash.now[:aler] = "Comment has not been created."
			@project = @stub.project
			render "stubs/show"
		end
	end

	private 

	def set_stub 
		@stub = Stub.find(params[:stub_id])
	end

	def comment_params
		params.require(:comment).permit(:text, :state_id)
	end	

end
