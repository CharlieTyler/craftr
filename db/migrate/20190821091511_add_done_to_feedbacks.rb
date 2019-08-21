class AddDoneToFeedbacks < ActiveRecord::Migration[5.1]
  def change
    add_column :feedbacks, :done?, :boolean
  end
end
