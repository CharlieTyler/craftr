class AddBannerImageToDistilleries < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :banner_image, :string
  end
end
