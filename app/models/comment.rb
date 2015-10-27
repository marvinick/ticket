class Comment < ActiveRecord::Base
  belongs_to :stub
  belongs_to :author
  belongs_to :state
  belongs_to :previous_state, class_name: "State"

  validates_presence_of :text

  belongs_to :author, class_name: "User"

  delegate :project, to: :stub

  scope :persisted, lambda { where.not(id: nil) }

  before_create :set_previous_state
  after_create :set_stub_state

  private 

  def set_previous_state 
    self.previous_state = stub.state
  end

  def set_stub_state 
  	stub.state = state 
  	stub.save!
  end
end
