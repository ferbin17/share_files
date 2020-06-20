class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email_id
      t.integer :upload_count, default: 0
      t.timestamps
    end
  end
end
