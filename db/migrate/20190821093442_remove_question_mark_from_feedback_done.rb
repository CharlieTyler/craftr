class RemoveQuestionMarkFromFeedbackDone < ActiveRecord::Migration[5.1]
  def change
    rename_column :feedbacks, :done?, :done
  end
end
