class AddUserToAccessKey < ActiveRecord::Migration
  def change
    add_reference :access_keys, :user, index: true
  end
end
