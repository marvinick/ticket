require "rails_helper"

RSpec.describe CommentNotifier, type: :mailer do 
	describe "created" do 
		let(:project) { FactoryGirl.create(:project)}
		let(:stub_owner) { FactoryGirl.create(:user)}
		let(:stub) do 
			FactoryGirl.create(:stub, project: project, author: stub_owner)
		end

		let(:commenter) { FactoryGirl.create(:user) }
		let(:comment) do 
			Comment.new(stub: stub, author: commenter, text: "Test comment")
		end

		let(:email) do 
			CommentNotifier.created(comment, stub_owner)
		end 

		it "sends out an email notification about a new comment" do 
			expect(email.to).to include stub_owner.email 
			title = "#{stub.name} for #{project.name} has been updated."
			expect(email.body.to_s).to include title 
			# expect(email.body.to_s).to include "#{commenter.email} wrote:"
			expect(email.body.to_s).to include comment.text
		end
	end
end