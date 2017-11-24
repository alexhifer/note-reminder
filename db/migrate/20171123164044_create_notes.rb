class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :body
      t.datetime :remind_at
      t.integer :user_id, limit: 5

      t.timestamps
    end

    add_index :notes, :user_id
  end
end
