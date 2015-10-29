require "rails_helper"

RSpec.feature "Users can watch and unwatch stubs" do 
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project)}
	let(:stub) do 
		FactoryGirl.create(:stub, project: project, author: user)
	end

	before do 
		assign_role!(user, "viewer", project)
		login_as(user)
		visit project_stub_path(project, stub)
	end

	scenario "successfully" do 
		within("#watchers") do 
			expect(page).to have_content user.email
		end

		click_link "Unwatch"
		expect(page).to have_content "You are no longer watching this " + "stub."

		within("#watchers") do 
			expect(page).to_not have_content user.email
		end

		click_link "Watch"
		expect(page).to have_content "You are now watching this stub."

		within("#watchers") do 
			expect(page).to have_content user.email
		end

	end
end