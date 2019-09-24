class AddDistilleryIdToAuthor < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :distillery_id, :integer
  end
end
