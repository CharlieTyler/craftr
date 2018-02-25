class AddDetailFieldsToDistillery < ActiveRecord::Migration[5.1]
  def change
    rename_column :distilleries, :description_short, :summary_text
    rename_column :distilleries, :description_first, :people_text
    rename_column :distilleries, :description_second, :range_text
    rename_column :distilleries, :banner_image, :summary_image
    add_column :distilleries, :people_image, :string
    add_column :distilleries, :range_image, :string
    add_column :distilleries, :blurb_1, :text
    add_column :distilleries, :image_1, :string
    add_column :distilleries, :blurb_2, :text
    add_column :distilleries, :image_2, :string
    add_column :distilleries, :blurb_3, :text
    add_column :distilleries, :image_3, :string
    add_column :distilleries, :website, :string
    add_column :distilleries, :facebook, :string
    add_column :distilleries, :longitude, :float
    add_column :distilleries, :latitude, :float
  end
end
