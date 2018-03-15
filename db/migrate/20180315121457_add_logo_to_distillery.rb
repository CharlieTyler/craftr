class AddLogoToDistillery < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :logo, :string
  end
end
