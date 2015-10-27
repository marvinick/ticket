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

	scenario "but cannot change the state without permission" do 
		assign_role!(user, :editor, project)
		visit project_stub_path(project, stub)

		expect(page).not_to have_select "State"
	end

	scenario "when adding a new tag to a stub" do 
		visit project_stub_path(project, stub) 
		expect(page).not_to have_content "bug"

		fill_in "Text", with: "Adding the bug tag"
		fill_in "Tags", with: "bug"
		click_button "Create Comment"

		expect(page).to have_content "Comment has been created."
		within("#stub #tags") do 
			expect(page).to have_content "bug"
		end
	end
end