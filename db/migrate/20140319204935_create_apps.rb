class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.integer :status
      t.string :url
      t.string :icon

      t.timestamps
    end
  end
end
