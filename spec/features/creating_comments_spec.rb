require "rails_helper"

RSpec.feature "Users can comment on stubs" do 
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) }
	let(:stub) { FactoryGirl.create(:stub, project: project, author: user) }

	before do 
		login_as(user)
		assign_role!(user, :manager, project) 
	end

	scenario "with valid attributes" do 
		visit project_stub_path(project, stub)
		fill_in "Text", with:"Added a comment!"
		click_button "Create Comment" 

		expect(page).to have_content "Comment has been created."
		within("#comments") do 
			expect(page).to have_content "Added a comment!"
		end
	end

	scenario "with invalid attributes" do 
		visit project_stub_path(project, stub)
		click_button "Create Comment" 

		expect(page).to have_content "Comment has not been created."
	end

	scenario "when changing a stub's state" do 
		FactoryGirl.create(:state, name: "Open")
		visit project_stub_path(project, stub)
		fill_in "Text", with: "This is a real issue"
		select "Open", from: "State"
		click_button "Create Comment"

		expect(page).to have_content "Comment has been created."
		within("#stub .state") do 
			expect(page).to have_content "Open"
		end

		within("#comments") do 
			expect(page).to have_content "state changed to Open"
		end
	end

end