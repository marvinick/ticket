class CommentsController < ApplicationController
	before_action :set_stub

	def create 
		@comment = @stub.comments.build(sanitized_parameters)
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
		params.require(:comment).permit(:text, :state_id, :tag_names)
	end	

	def sanitized_parameters
		whitelisted_params = comment_params

		unless policy(@stub).change_state? 
			whitelisted_params.delete(:state_id)
		end

		unless policy(@stub).tag?
			whitelisted_params.delete(:tag_names)
		end

		whitelisted_params
	end

end
