require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do 
	let(:user) { FactoryGirl.create(:user) }
	let(:admin) { FactoryGirl.create(:user, :admin) }
	let(:project) { FactoryGirl.create(:project) }
	let(:stub) do
		FactoryGirl.create(:stub, project: project, author: user)
	end

	context "anonymous users" do 
		scenario "cannot see the New Project link" do
			visit "/"
			expect(page).not_to have_link "New Project" 
		end
	end

	context "non-admin users (project viewers)" do 
		before do
			login_as(user)
			assign_role!(user, :viewer, project)
		end

		scenario "cannot see the New Project link" do 
			visit "/"
			expect(page).not_to have_link "New Project"
		end

		scenario "cannot see the Delete Project link" do 
			visit project_path(project)
			expect(page).not_to have_link "Delete Project"
		end

		scenario "cannot see the edit project link" do 
			visit project_path(project)
			expect(page).not_to have_link "Edit Project"
		end

		scenario "cannot see the New Stub link" do 
			visit project_path(project)
			expect(page).not_to have_link "New Stub"
		end

		scenario "cannot see the Edit Stub link" do
			visit project_stub_path(project, stub)
			expect(page).not_to have_link "Edit Stub"
		end

		scenario "cannot see the Delete Stub link" do
			visit project_stub_path(project, stub)
			expect(page).not_to have_link "Delete Stub"
		end

		scenario "cannot see the New Comment form" do 
			visit project_stub_path(project, stub) 
			expect(page).not_to have_heading "New Comment"
		end
	end

	context "admin users" do 
		before { login_as(admin) }

		scenario "can see the New Project link" do 
			visit "/"
			expect(page).to have_link "New Project" 
		end

		scenario "can see the Delete Project link" do 
			visit project_path(project)
			expect(page).to have_link "Delete Project"
		end

		scenario "can see the Edit Project link" do
			visit project_path(project)
			expect(page).to have_link "Edit Project"
		end

		scenario "can see the new stub link" do 
			visit project_path(project)
			expect(page).to have_link "New Stub"
		end

		scenario "can see the Edit Stub link" do 
			visit project_stub_path(project, stub)
			expect(page).to have_link "Edit Stub"
		end

		scenario "can see the Delete Stub link" do 
			visit project_stub_path(project, stub) 
			expect(page).to have_link "Delete Stub"
		end

		scenario "can see the New Comment form" do 
			visit project_stub_path(project, stub)
			expect(page).to have_heading "New Comment"
		end
 	end
end
