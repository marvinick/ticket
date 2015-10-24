require "rails_helper" 

RSpec.feature "Users can view a stub's attached files" do 
	let(:user) { FactoryGirl.create :user }
	let(:project) { FactoryGirl.create :project }
	let(:stub) { FactoryGirl.create :stub, project: project, author: user }
	let!(:attachment) { FactoryGirl.create :attachment, stub: stub, file_to_attach: "spec/fixtures/speed.txt" }

	before do 
		assign_role!(user, :viewer, project) 
		login_as(user) 
	end 

	scenario "successfully" do 
		visit project_stub_path(project, stub) 
		click_link "speed.txt"

		expect(current_path).to eq attachment_path(attachment)
		expect(page).to have_content "The blink tag can blink faster"
	end
end