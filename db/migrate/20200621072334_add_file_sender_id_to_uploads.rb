class AddFileSenderIdToUploads < ActiveRecord::Migration[6.0]
  def change
    add_column :uploads, :file_sender_id, :integer
  end
end
