class Comment < ActiveRecord::Base
  belongs_to :stub
  belongs_to :author
  belongs_to :state

  validates_presence_of :text

  belongs_to :author, class_name: "User"

  delegate :project, to: :stub

  scope :persisted, lambda { where.not(id: nil) }
end
