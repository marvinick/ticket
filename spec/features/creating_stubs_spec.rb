require 'rails_helper'

RSpec.feature "Users can create a new stubs" do 
	let(:user) { FactoryGirl.create(:user) }

	before do
		login_as(user) 
		project = FactoryGirl.create(:project, name: "Internet Explorer")
		assign_role!(user, :editor, project)
		
		visit project_path(project)
		click_link "New Stub" 
	end  

	scenario "with valid attributes" do 
		fill_in "Name", with: "Non-standards compliance" 
		fill_in "Desription", with: "My pages are ugly"
		click_button "Create Stub"

		expect(page).to have_content "Stub has been created" 
		within("#stub") do 
			expect(page).to have_content "Author: #{user.email}"
		end
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

	scenario "with an attachment" do 
		fill_in "Name", with: "Add documentation for blink tag"
		fill_in "Desription", with: "The blink tag has a speed attribute"
		attach_file "File #1", "spec/fixtures/speed.txt"
		click_button "Create Stub"

		expect(page).to have_content "Stub has been created."

		within("#stub .attachments") do 
			expect(page).to have_content "speed.txt"
		end
	end

	scenario "persisting file uploads accross form displays" do 
		attach_file "File #1", "spec/fixtures/speed.txt"
		click_button "Create Stub"

		fill_in "Name", with: "Add documentation for blink tag"
		fill_in "Desription", with: "The blink tag has a speed attribute"
		click_button "Create Stub"
		within("#stub .attachments") do 
			expect(page).to have_content "speed.txt"
		end
	end

	scenario "attaching multiple attaachments" do 
		fill_in "Name", with: "Add documentation for blink tag"
		fill_in "Desription", with: "The blink tag has a speed attribute"

		attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
		attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
		attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")

		click_button "Create Stub"

		expect(page).to have_content "Stub has been created."

		within("#stub .attachments") do 
			expect(page).to have_content "speed.txt"
			expect(page).to have_content "spin.txt"
			expect(page).to have_content "gradient.txt"
		end
	end
 end
 