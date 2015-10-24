class RemoveAttachmentFromStubs < ActiveRecord::Migration
  def change
    remove_column :stubs, :attachment, :string
  end
end
