require "rails_helper"

RSpec.feature "users can delete stubs" do 
	let(:project) { FactoryGirl.create(:project) } 
	let(:stub) { FactoryGirl.create(:stub, project: project) }

	before do 
		visit project_stub_path(project, stub)
	end

	scenario "successfuly" do 
		click_link "Delete Stub"

		expect(page).to have_content "Stub has been deleted" 
		expect(page.current_url).to eq project_url(project)
	end
end