class Stub < ActiveRecord::Base
	validates :name, presence: true
	validates :desription, presence: true, length: { minimum: 10 }
  belongs_to :project
  belongs_to :author, class_name: "User"
end
