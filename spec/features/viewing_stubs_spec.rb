require 'rails_helper'

RSpec.feature "Users can view stubs" do 
	before do 
		author = FactoryGirl.create(:user)
		sublime = FactoryGirl.create(:project, name: "Sublime Text 3" )
		FactoryGirl.create(:stub, project: sublime, author: author, name: 'Make it shiny', desription: "Gradients! Starbucks! Oh my!")

		ie = FactoryGirl.create(:project, name: "Internet Explorer")
		FactoryGirl.create(:stub, project: ie, author: author, name: "Standards compliance", desription: "Isn't a joke")

		visit "/"
	end

	scenario "for a given project" do 
		click_link "Sublime Text 3"

		expect(page).to have_content "Make it shiny"
		expect(page).to_not have_content "Standards compliance"

		click_link "Make it shiny"
		within('#stub h2') do 
			expect(page).to have_content "Make it shiny"
		end

		expect(page).to have_content "Gradients! Starbucks! Oh my!"
	end
end 