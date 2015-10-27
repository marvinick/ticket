class TagsController < ApplicationController
	def remove 
		@stub = Stub.find(params[:stub_id])
		@tag = Tag.find(params[:id])
		authorize @stub, :tag?

		@stub.tags.destroy(@tag)
		head :ok
	end
end
