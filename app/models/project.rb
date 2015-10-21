class Project < ActiveRecord::Base
	has_many :stubs, dependent: :delete_all
	validates_presence_of :name
	has_many :roles, dependent: :delete_all
end
		 