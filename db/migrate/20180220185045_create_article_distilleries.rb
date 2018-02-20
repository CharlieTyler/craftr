class CreateArticleDistilleries < ActiveRecord::Migration[5.1]
  def change
    create_table :article_distilleries do |t|
      t.integer :article_id
      t.integer :distillery_id
      t.timestamps
    end
  end
end
