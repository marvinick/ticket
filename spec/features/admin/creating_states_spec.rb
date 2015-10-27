require "rails_helper"

RSpec.feature "Admins can create new states for stubs" do 
	before do 
		login_as(FactoryGirl.create(:user, :admin))
	end

	scenario "with valid credentials" do 
		visit admin_root_path 
		click_link "States" 
		click_link "New State" 

		fill_in "Name", with: "Won't fix"
		fill_in "Color", with: "orange"
		click_button "Create State"

		expect(page).to have_content "State has been created."
	end
end