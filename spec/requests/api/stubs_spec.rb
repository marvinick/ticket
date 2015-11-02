require "rails_helper"

RSpec.describe "Stubs API" do 
	let(:user)  { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) }
	let(:state) { FactoryGirl.create(:state, name: "Open") }
	let(:stub) do 
		FactoryGirl.create(:stub, project: project, state: state)
	end

	before do 
		assign_role!(user, :manager, project)
		user.generate_api_key
	end 

	context "as an authenticated user" do 
		let(:headers) do 
			{ "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
		end

		it "retrieves a stub's information" do 
			get api_project_stub_path(project, stub, format: :json), {}, headers
			expect(response.status).to eq 200

			json = StubSerializer.new(stub).to_json
			expect(response.body).to eq json 
		end
	end
end