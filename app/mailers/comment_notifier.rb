class CommentNotifier < ApplicationMailer
	def created(comment, user)
		@comment = comment 
		@user = user 
		@stub = comment.stub
		@project = @stub.project 

		subject = "[ticketee] #{@project.name} - #{@stub.name}"
		mail(to: user.email, subject: subject)
	end
end
