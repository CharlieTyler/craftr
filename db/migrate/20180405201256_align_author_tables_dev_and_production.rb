class AlignAuthorTablesDevAndProduction < ActiveRecord::Migration[5.1]
  def change
    # Hard reset after running a migration, meaining production and dev databases our of sync
    # Attempt 1 to fix
    if column_exists? :authors, :website
      remove_column :authors, :website
    end

    if column_exists? :authors, :description
      remove_column :authors, :description
    end

    if column_exists? :authors, :instagram_user_id
      remove_column :authors, :instagram_user_id
    end

    unless column_exists? :authors, :name
      add_column :authors, :name, :string
    end

    unless column_exists? :authors, :location
      add_column :authors, :location, :string
    end

    unless column_exists? :authors, :bio
      add_column :authors, :bio, :text
    end

    unless column_exists? :authors, :background_image
      add_column :authors, :background_image, :string
    end

    unless column_exists? :authors, :mugshot
      add_column :authors, :mugshot, :string
    end

    unless column_exists? :authors, :instagram_link
      add_column :authors, :instagram_link, :string
    end

    unless column_exists? :authors, :website_link
      add_column :authors, :website_link, :string
    end
  end
end
