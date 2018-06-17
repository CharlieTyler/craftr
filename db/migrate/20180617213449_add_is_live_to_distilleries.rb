class AddIsLiveToDistilleries < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :is_live, :boolean, default: true
  end
end
