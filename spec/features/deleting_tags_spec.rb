require "rails_helper"

RSpec.feature "Users can delete unwanted tags from a stub" do 
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) }
	let(:stub) do 
		FactoryGirl.create(:stub, project: project, tag_names: "ThisTagMustDie", author: user) 
	end

	before do 
		login_as(user)
		assign_role!(user, :manager, project)
		visit project_stub_path(project, stub)
	end

	scenario "successfully", js: true do 
		within tag("ThisTagMustDie") do 
			click_link "remove"
		end
		expect(page).to_not have_content "ThisTagMustDie"
	end

end
