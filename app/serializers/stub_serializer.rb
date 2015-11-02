class StubSerializer < ActiveModel::Serializer
  attributes :id, :name, :desription, :project_id, :created_at, :updated_at, :author_id, :state_id

  has_one :state
end
