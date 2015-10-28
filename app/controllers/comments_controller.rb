class CommentsController < ApplicationController
	before_action :set_stub

	def create 
		@creator = CommentCreator.build(@stub.comments, current_user, sanitized_parameters)
		authorize @creator.comment, :create?

		if @creator.save
			flash[:notice] = "Comment has been created."
			redirect_to [@stub.project, @stub]
		else
			flash.now[:alert] = "Comment has not been created."
			@project = @stub.project 
			@comment = @creator.comment 
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
