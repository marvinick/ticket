require 'rails_helper'

RSpec.feature "Users can create a new stubs" do 
	before do 
		project = FactoryGirl.create(:project, name: "Internet Explorer")
		visit project_path(project)
		click_link "New Stub" 
	end  

	scenario "with valid attributes" do 
		fill_in "Name", with: "Non-standards compliance" 
		fill_in "Desription", with: "My pages are ugly"
		click_button "Create Stub"

		expect(page).to have_content "Stub has been created" 
	end

	scenario "when providing invalid attributes" do 
		click_button "Create Stub" 

		expect(page).to have_content "Stub has not been created"
		expect(page).to have_content "Name can't be blank"
		expect(page).to have_content "Desription can't be blank"
	end

	scenario "with an invalid desription" do 
		fill_in "Name", with: "Non standards compliance"
		fill_in "Desription", with: "It sucks"
		click_button "Create Stub"
		expect(page).to have_content "Stub has not been created"
		expect(page).to have_content "Desription is too short"
	end
end
 