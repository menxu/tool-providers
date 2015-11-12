class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :image
      t.integer :user_id

      t.timestamps false
    end
  end
end
