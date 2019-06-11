class AddFeaturedToDistillery < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :featured, :boolean
  end
end
