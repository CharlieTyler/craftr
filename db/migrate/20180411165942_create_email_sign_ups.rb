class CreateEmailSignUps < ActiveRecord::Migration[5.1]
  def change
    create_table :email_sign_ups do |t|
      t.string :email
      t.timestamps
    end
  end
end
