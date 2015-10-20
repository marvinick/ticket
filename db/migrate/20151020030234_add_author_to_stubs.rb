class AddAuthorToStubs < ActiveRecord::Migration
  def change
    add_reference :stubs, :author, index: true
    add_foreign_key :stubs, :users, column: :author_id
  end
end
