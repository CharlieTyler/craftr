class AddInstagramUrlToDistilleries < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :instagram_url, :string
  end
end
