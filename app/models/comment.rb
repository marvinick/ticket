class Comment < ActiveRecord::Base
  belongs_to :stub
  belongs_to :author
  belongs_to :state
  belongs_to :previous_state, class_name: "State"

  attr_accessor :tag_names

  validates_presence_of :text

  belongs_to :author, class_name: "User"

  delegate :project, to: :stub

  scope :persisted, lambda { where.not(id: nil) }

  before_create :set_previous_state
  after_create :set_stub_state
  after_create :associate_tags_with_stub
  after_create :author_watches_stub 

  private 

  def set_previous_state 
    self.previous_state = stub.state
  end

  def set_stub_state 
  	stub.state = state 
  	stub.save!
  end

  def associate_tags_with_stub 
    if tag_names
      tag_names.split.each do |name| 
        stub.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

  def author_watches_stub 
    if author.present? && !stub.watchers.include?(author)
      stub.watchers << author
    end
  end
end
