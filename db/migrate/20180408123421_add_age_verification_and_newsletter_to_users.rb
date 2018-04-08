class AddAgeVerificationAndNewsletterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :age_verified, :boolean, default: false
    add_column :users, :newsletter_sign_up, :boolean, default: false
  end
end
