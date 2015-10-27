require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { Project.create!(name: "Ticketee")} 
	let(:state) { State.create!(name: "Hacked") }

	let(:stub) do 
		project.stubs.create(name: "State transitions", desription: "Can't be hacked.", author: user)
	end

	context "a user without permission to set a state" do 
		before :each do 
			assign_role!(user, :editor, project)
			sign_in user
		end

		it "cannot transition a state by passing through stata_id" do 
			post :create, { comment: { text: "Did I hack it??", state_id: state.id}, stub_id: stub.id }
			stub.reload
			expect(stub.state).to be_nil
		end
	end

	context "a user without permission to tag a stub" do 
		before do 
			assign_role!(user, :editor, project) 
			sign_in user
		end

		it "cannot tag a stub when creating a comment" do 
			post :create, { comment: { text: "Tag!", tag_names: "one two" }, stub_id: stub.id }
			stub.reload
			expect(stub.tags).to be_empty
		end
	end
end

