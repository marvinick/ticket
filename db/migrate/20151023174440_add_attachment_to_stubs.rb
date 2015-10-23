class AddAttachmentToStubs < ActiveRecord::Migration
  def change
    add_column :stubs, :attachment, :string
  end
end
