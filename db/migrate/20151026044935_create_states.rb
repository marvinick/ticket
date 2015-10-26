class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :color
    end

    add_reference :stubs, :state, index: true, foreign_key: true
    add_reference :comments, :state, foreign_key: true
  end
end
