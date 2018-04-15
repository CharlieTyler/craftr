class RemoveTypeFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :type
    add_column :authors, :user_id, :integer
  end
end
