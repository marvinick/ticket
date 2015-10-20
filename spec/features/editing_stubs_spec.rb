require "rails_helper"

RSpec.feature "Users can edit existing stub" do 
	let(:project) { FactoryGirl.create(:project) }
	let(:stub) { FactoryGirl.create(:stub, project: project) }

	before do 
		visit project_stub_path(project, stub)
		click_link "Edit Stub"
	end

	scenario "with valid attributes" do 
		fill_in "Name", with: "Make it really shiny!"
		click_button "Update Stub"

		expect(page).to have_content "Stub has been updated"

		within('#stub h2') do 
			expect(page).to have_content "Make it really shiny!"
			expect(page).not_to have_content stub.name 
		end
	end
 
	scenario "with invalid attributes" do 
		fill_in "Name", with: ""
		click_button "Update Stub"

		expect(page).to have_content "Stub has not been updated"
	end
end
