class CreateUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :uploads do |t|
      t.string :uuid
      t.string :filename
      t.integer :file_size
      t.string :path
      t.integer :uploaded_size, default: 0
      t.integer :file_sender_id, :integer
      t.timestamps
    end
  end
end
