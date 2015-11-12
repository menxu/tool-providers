class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :action
      t.boolean :is_read
      t.boolean :must_action
      t.string :status
      t.string :target_type
      t.datetime :read_at

      t.timestamps
    end
  end
end
