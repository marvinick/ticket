class CreateJoinTableTagsStubs < ActiveRecord::Migration
  def change
    create_join_table :tags, :stubs do |t|
      t.index [:tag_id, :stub_id]
      t.index [:stub_id, :tag_id]
    end
  end
end
