class CreatePostages < ActiveRecord::Migration[5.1]
  def change
    create_table :postages do |t|
      t.string :postage_label_url
      t.string :tracking_code
      t.integer :sold_item_id
      t.timestamps
    end
  end
end
