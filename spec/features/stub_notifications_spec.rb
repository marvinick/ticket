require "rails_helper"

RSpec.feature "Users can receive notifications about stub updates" do 
	let(:alice) { FactoryGirl.create(:user, email: "alice@example.com")}
	let(:bob) { FactoryGirl.create(:user, email: "bob@example.com")}
	let(:project) { FactoryGirl.create(:project)} 
	let(:stub) do 
		FactoryGirl.create(:stub, project: project, author: alice)
	end

	before do 
		assign_role!(alice, :manager, project)
		assign_role!(bob, :manager, project)

		login_as(bob)
		visit project_stub_path(project, stub)
	end

	scenario "stub authors automatically receive notifications" do 
		fill_in "Text", with: "Is it out yet?"
		click_button "Create Comment"

		email = find_email!(alice.email)
		expected_subject = "[ticketee] #{project.name} - #{stub.name}"
		expect(email.subject).to eq expected_subject

		click_first_link_in_email(email)
		expect(current_path).to eq project_stub_path(project, stub)
	end
end