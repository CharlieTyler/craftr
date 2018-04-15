class ChangeInstagramUserIdToString < ActiveRecord::Migration[5.1]
  def change
    change_column :distilleries, :instagram_user_id, :string
  end
end
