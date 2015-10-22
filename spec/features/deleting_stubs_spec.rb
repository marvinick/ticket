require "rails_helper"

RSpec.feature "users can delete stubs" do 
	let(:author) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) } 
	let(:stub) do 
	  FactoryGirl.create(:stub, project: project, author: author) 
	end

	before do 
		login_as(author)
		assign_role!(author, :manager, project)
		visit project_stub_path(project, stub)
	end

	scenario "successfuly" do 
		click_link "Delete Stub"

		expect(page).to have_content "Stub has been deleted" 
		expect(page.current_url).to eq project_url(project)
	end
end