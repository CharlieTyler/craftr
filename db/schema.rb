# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20210207170709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "line_1"
    t.string "line_2"
    t.string "line_3"
    t.string "post_town"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "easypost_address_id"
    t.integer "distillery_id"
    t.string "phone_number"
    t.string "country", default: "GB"
  end

  create_table "article_categories", force: :cascade do |t|
    t.integer "article_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_distilleries", force: :cascade do |t|
    t.integer "article_id"
    t.integer "distillery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_products", force: :cascade do |t|
    t.integer "article_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_recipes", force: :cascade do |t|
    t.integer "article_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "banner_image"
    t.string "image_first"
    t.string "image_second"
    t.string "image_third"
    t.text "description_first"
    t.text "description_second"
    t.text "description_third"
    t.integer "author_id"
    t.string "slug"
    t.integer "user_article_views_count"
    t.boolean "featured", default: false
    t.text "description_fourth"
    t.text "description_fifth"
    t.string "image_fourth"
    t.string "image_fifth"
    t.index ["featured"], name: "index_articles_on_featured"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "name"
    t.string "location"
    t.text "bio"
    t.string "background_image"
    t.string "mugshot"
    t.string "instagram_link"
    t.string "website_link"
    t.string "slug"
    t.string "bio_image"
    t.integer "distillery_id"
  end

  create_table "batches", force: :cascade do |t|
    t.string "easypost_batch_id"
    t.string "scanform_id"
    t.boolean "shipped", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "distillery_id"
    t.datetime "shipped_at"
    t.datetime "scanform_created_at"
  end

  create_table "carousel_features", force: :cascade do |t|
    t.string "line_1"
    t.string "line_2"
    t.string "cta_text"
    t.string "link_url"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.string "gradient_from"
    t.string "gradient_to"
    t.index ["row_order"], name: "index_carousel_features_on_row_order"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "featured", default: false
    t.string "banner_image"
    t.string "instagram_hashtag"
    t.string "slug"
    t.integer "row_order"
    t.string "gradient_from"
    t.string "gradient_to"
    t.text "description"
    t.index ["featured"], name: "index_categories_on_featured"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "collection_products", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "product_id"
    t.boolean "featured"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "category_id"
    t.boolean "featured"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_collections_on_slug", unique: true
  end

  create_table "distilleries", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "summary_text"
    t.text "people_text"
    t.text "range_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "summary_image"
    t.string "people_image"
    t.string "range_image"
    t.text "blurb_1"
    t.string "image_1"
    t.text "blurb_2"
    t.string "image_2"
    t.text "blurb_3"
    t.string "image_3"
    t.string "website"
    t.string "facebook"
    t.float "longitude"
    t.float "latitude"
    t.string "instagram_user_id"
    t.string "slug"
    t.string "logo"
    t.string "youtube_video_url"
    t.string "stripe_id"
    t.boolean "is_test", default: false
    t.boolean "is_live", default: true
    t.string "instagram_url"
    t.boolean "featured"
    t.index ["slug"], name: "index_distilleries_on_slug", unique: true
  end

  create_table "email_sign_ups", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "user_id"
    t.string "email"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "done"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "product_id"
    t.string "image"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "shipping_address_id"
    t.integer "shipping_type_id"
    t.integer "paid_shipping_price"
    t.boolean "paid", default: false
    t.integer "voucher_id"
    t.index ["paid"], name: "index_orders_on_paid"
  end

  create_table "postages", force: :cascade do |t|
    t.string "postage_label_url"
    t.string "tracking_code"
    t.integer "sold_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "easypost_shipment_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.integer "row_order"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.text "description_short"
    t.text "description_first"
    t.text "description_second"
    t.float "alcohol_percentage"
    t.integer "distillery_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "featured", default: false
    t.json "images"
    t.string "slug"
    t.integer "dry_to_sweet"
    t.integer "subtle_to_intense"
    t.integer "fresh_to_complex"
    t.integer "size_ml"
    t.boolean "is_live", default: true
    t.boolean "is_in_stock", default: true
    t.integer "distillery_take"
    t.integer "weight"
    t.integer "user_product_views_count"
    t.boolean "is_test", default: false
    t.string "GTIN"
    t.integer "original_price"
    t.boolean "manual_shipping"
    t.index ["featured"], name: "index_products_on_featured"
    t.index ["is_live"], name: "index_products_on_is_live"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "recipe_categories", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_comments", force: :cascade do |t|
    t.text "message"
    t.integer "user_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.string "quantity"
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.index ["row_order"], name: "index_recipe_ingredients_on_row_order"
  end

  create_table "recipe_products", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "description"
    t.text "method"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "featured", default: false
    t.string "banner_image"
    t.text "blurb"
    t.text "variants"
    t.string "instagram_hashtag"
    t.string "slug"
    t.integer "user_recipe_views_count"
    t.integer "prep_time_in_minutes"
    t.string "cuisine"
    t.index ["featured"], name: "index_recipes_on_featured"
    t.index ["slug"], name: "index_recipes_on_slug", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text "message"
    t.integer "rating"
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified", default: false
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id", "product_id"], name: "index_reviews_on_user_id_and_product_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_types", force: :cascade do |t|
    t.string "name"
    t.string "shipping_time"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sold_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_item_id"
    t.integer "quantity"
    t.integer "item_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.integer "distillery_take"
    t.boolean "shipping_label_created", default: false
    t.integer "batch_id"
    t.boolean "shipped", default: false
    t.datetime "shipped_at"
    t.datetime "shipping_label_created_at"
    t.boolean "manual_shipping"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.string "slug"
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug"
  end

  create_table "user_article_views", force: :cascade do |t|
    t.integer "user_id"
    t.integer "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_favourite_products", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_favourite_recipes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_product_views", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_recipe_views", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.boolean "age_verified", default: false
    t.boolean "newsletter_sign_up", default: false
    t.string "stripe_customer_id"
    t.integer "distillery_id"
    t.boolean "privacy_policy_accepted", default: false
    t.boolean "is_beta_tester", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vouchers", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "value"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.boolean "live"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
