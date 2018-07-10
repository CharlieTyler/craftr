class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.string :easypost_batch_id
      t.string :scanform_id
      t.boolean :shipped, default: false
      t.timestamps
    end
  end
end
