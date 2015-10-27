class State < ActiveRecord::Base
	has_many :stubs
	has_many :comments

	def to_s 
		name
	end

	def make_default!
		State.update_all(default: false)
		update!(default: true)
	end
end
