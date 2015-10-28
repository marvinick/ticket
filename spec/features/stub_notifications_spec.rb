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

		login_as(alice)
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

	scenario "comment authors are automatically subscribed to a stub" do 
		fill_in "Text", with: "Is it out yet?"
		click_button "Create Comment"
		click_link "Sign out"

		reset_mailer

		login_as(bob)
		visit project_stub_path(project, stub)
		fill_in "Text", with: "Not yet - sorry!"
		click_button "Create Comment"

		expect(page).to have_content "Comment has been created."
		expect(unread_emails_for(bob.email).count).to eq 0
		expect(unread_emails_for(alice.email).count).to eq 1
	end

end