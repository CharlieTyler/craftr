class ChangeInstagramUserIdsToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :distilleries, :instagram_username
    add_column :distilleries, :instagram_user_id, :integer
    remove_column :authors, :instagram_username
    add_column :authors, :instagram_user_id, :integer
  end
end
