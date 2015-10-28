require "rails_helper"

RSpec.feature "Users can search for stub that matching specific criteria" do 
	let(:user) { FactoryGirl.create(:user)}
	let(:project) { FactoryGirl.create(:project)}
	
	let!(:stub_1)  do 
		FactoryGirl.create(:stub, name: "Create projects", project: project, author: user, tag_names: "iteration_1")
	end

	let!(:stub_2) do 
		FactoryGirl.create(:stub, name: "Create users", project: project, author: user, tag_names: "iteration_2")
	end

	before do 
		assign_role!(user, :manager, project)
		login_as(user)
		visit project_path(project)
	end

	scenario "searching by tag" do 
		fill_in "Search", with: "tag:iteration_1"
		click_button "Search"
		# within("#stubs") do 
			expect(page).to have_link "Create projects"
			expect(page).to_not have_link "Create users"
		# end
	end
end