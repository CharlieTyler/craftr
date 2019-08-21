class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :email
      t.text :description
      t.string :url
      t.timestamps
    end
  end
end
