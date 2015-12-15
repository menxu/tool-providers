class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.integer :kind
      t.string :desc
      t.string :icon
      t.string :url
      t.timestamps null: false
    end
    add_index :sites, :name
    add_index :sites, :kind
  end
end
