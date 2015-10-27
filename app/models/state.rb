class State < ActiveRecord::Base
	has_many :stubs
	has_many :comments

	def to_s 
		name
	end
end
