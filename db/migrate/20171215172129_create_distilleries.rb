class CreateDistilleries < ActiveRecord::Migration[5.1]
  def change
    create_table :distilleries do |t|
      t.string :name
      t.string :location
      t.text :description_short
      t.text :description_first
      t.text :description_second
      t.timestamps
    end
  end
end
