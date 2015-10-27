require 'rails_helper'

RSpec.describe StubsController, type: :controller do
	let(:project) { FactoryGirl.create(:project) }
	let(:user) { FactoryGirl.create(:user) }

	before :each do 
		assign_role!(user, :editor, project)
		sign_in user
	end

	it "can create stubs, but not tag them" do 
		post :create, stub: { name: "New stub!", desription: "Brand spankin' new", tag_names: "there are tags"}, project_id: project.id
		expect(Stub.last.tags).to be_empty
	end
end
