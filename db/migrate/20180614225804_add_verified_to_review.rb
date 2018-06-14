class AddVerifiedToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :verified, :boolean, default: false
  end
end
