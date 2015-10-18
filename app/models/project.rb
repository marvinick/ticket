class Project < ActiveRecord::Base
	has_many :stubs
	validates_presence_of :name

end
		