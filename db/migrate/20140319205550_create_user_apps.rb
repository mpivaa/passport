class CreateUserApps < ActiveRecord::Migration
  def change
    create_table :user_apps do |t|
      t.references :user, index: true
      t.references :app, index: true

      t.timestamps
    end
  end
end
