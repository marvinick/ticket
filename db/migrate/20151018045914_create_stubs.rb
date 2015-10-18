class CreateStubs < ActiveRecord::Migration
  def change
    create_table :stubs do |t|
      t.string :name
      t.text :desription
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
