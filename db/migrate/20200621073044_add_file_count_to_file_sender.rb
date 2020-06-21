class AddFileCountToFileSender < ActiveRecord::Migration[6.0]
  def change
    add_column :file_senders, :total_files, :integer, default: 0
    add_column :file_senders, :uploaded_files, :integer, default: 0 
  end
end
