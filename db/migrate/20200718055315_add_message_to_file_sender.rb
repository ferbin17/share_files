class AddMessageToFileSender < ActiveRecord::Migration[6.0]
  def change
    add_column :file_senders, :messages, :text
  end
end
