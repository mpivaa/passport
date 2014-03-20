class CreateAccessKeys < ActiveRecord::Migration
  def change
    create_table :access_keys do |t|
      t.string :key
      t.datetime :expire_at

      t.timestamps
    end
  end
end
