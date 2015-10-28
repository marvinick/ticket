class CreateJoinTableStubWatchers < ActiveRecord::Migration
  def change
    create_join_table :stubs, :users, table_name: :stub_watchers do |t|
      # t.index [:stub_id, :user_id]
      # t.index [:user_id, :stub_id]
    end
  end
end
