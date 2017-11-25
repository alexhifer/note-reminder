class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :body
      t.datetime :remind_at
      t.integer :user_id, limit: 5
      t.boolean :is_sent, default: false

      t.timestamps
    end

    add_index :notes, :user_id
    add_index :notes, :is_sent
  end
end
