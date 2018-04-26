class AddStripeIdToDistillery < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :stripe_id, :string
  end
end
