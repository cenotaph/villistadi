# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141022124151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true, using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.boolean  "published"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type"
    t.integer  "commentable_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "address1"
    t.string   "city"
    t.string   "postcode"
    t.string   "venue"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "description"
    t.string   "contact_name"
    t.string   "contact_contact"
    t.boolean  "approved",                                 default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "latitude",        precision: 10, scale: 6
    t.decimal  "longitude",       precision: 10, scale: 6
    t.string   "address2"
  end

  add_index "events", ["project_id"], name: "index_events_on_project_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "forumposts", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "sticky"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forumposts", ["project_id"], name: "index_forumposts_on_project_id", using: :btree
  add_index "forumposts", ["user_id"], name: "index_forumposts_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "internallink_translations", force: true do |t|
    t.integer  "internallink_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  add_index "internallink_translations", ["internallink_id"], name: "index_internallink_translations_on_internallink_id", using: :btree
  add_index "internallink_translations", ["locale"], name: "index_internallink_translations_on_locale", using: :btree

  create_table "internallinks", force: true do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "parameter"
    t.string   "name"
    t.boolean  "published"
    t.string   "custom_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_hierarchies", force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "menu_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "menu_anc_desc_udx", unique: true, using: :btree
  add_index "menu_hierarchies", ["descendant_id"], name: "menu_desc_idx", using: :btree

  create_table "menu_translations", force: true do |t|
    t.integer  "menu_id",      null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  add_index "menu_translations", ["locale"], name: "index_menu_translations_on_locale", using: :btree
  add_index "menu_translations", ["menu_id"], name: "index_menu_translations_on_menu_id", using: :btree

  create_table "menus", force: true do |t|
    t.integer  "city_id"
    t.string   "item_type"
    t.integer  "item_id"
    t.integer  "parent_id"
    t.integer  "sort_order"
    t.boolean  "published"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["city_id"], name: "index_menus_on_city_id", using: :btree

  create_table "page_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "page_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "page_anc_desc_udx", unique: true, using: :btree
  add_index "page_hierarchies", ["descendant_id"], name: "page_desc_idx", using: :btree

  create_table "page_translations", force: true do |t|
    t.integer  "page_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "body"
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "slug"
    t.boolean  "published"
    t.integer  "city_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["city_id"], name: "index_pages_on_city_id", using: :btree

  create_table "photo_translations", force: true do |t|
    t.integer  "photo_id",   null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "photo_translations", ["locale"], name: "index_photo_translations_on_locale", using: :btree
  add_index "photo_translations", ["photo_id"], name: "index_photo_translations_on_photo_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "image"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.integer  "image_size"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["imageable_id", "imageable_type"], name: "index_photos_on_imageable_id_and_imageable_type", using: :btree

  create_table "place_translations", force: true do |t|
    t.integer  "place_id",           null: false
    t.string   "locale",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.text     "getting_there"
    t.text     "see_and_experience"
    t.text     "more_information"
    t.text     "facts"
    t.text     "future_of"
  end

  add_index "place_translations", ["locale"], name: "index_place_translations_on_locale", using: :btree
  add_index "place_translations", ["place_id"], name: "index_place_translations_on_place_id", using: :btree

  create_table "places", force: true do |t|
    t.integer  "city_id"
    t.decimal  "sw_lat",                            precision: 10, scale: 8
    t.decimal  "sw_lng",                            precision: 10, scale: 8
    t.decimal  "ne_lat",                            precision: 10, scale: 8
    t.decimal  "ne_lng",                            precision: 10, scale: 8
    t.string   "slug"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background"
    t.integer  "background_width"
    t.integer  "background_height"
    t.integer  "background_size",         limit: 8
    t.string   "background_content_type"
    t.string   "pdf"
  end

  add_index "places", ["city_id"], name: "index_places_on_city_id", using: :btree

  create_table "post_translations", force: true do |t|
    t.integer  "post_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "city_id"
    t.string   "slug"
    t.string   "icon"
    t.integer  "icon_width"
    t.integer  "icon_height"
    t.string   "icon_content_type"
    t.integer  "icon_size",         limit: 8
    t.boolean  "published"
    t.datetime "published_at"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "posts", ["city_id"], name: "index_posts_on_city_id", using: :btree

  create_table "project_translations", force: true do |t|
    t.integer  "project_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "tagline"
    t.text     "description"
  end

  add_index "project_translations", ["locale"], name: "index_project_translations_on_locale", using: :btree
  add_index "project_translations", ["project_id"], name: "index_project_translations_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "city_id"
    t.string   "slug"
    t.boolean  "restricted_membership"
    t.boolean  "private"
    t.integer  "maximum_members"
    t.boolean  "has_forum"
    t.boolean  "members_can_create_forum_topics"
    t.boolean  "notify_admin_of_new_member"
    t.integer  "owner_id"
    t.string   "image"
    t.integer  "image_size",                      limit: 8
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_users", id: false, force: true do |t|
    t.integer "project_id",     null: false
    t.integer "user_id",        null: false
    t.boolean "is_admin"
    t.boolean "receive_emails"
  end

  add_index "projects_users", ["project_id", "user_id"], name: "by_project_and_user", unique: true, using: :btree
  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id", using: :btree
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "spot_translations", force: true do |t|
    t.integer  "spot_id",     null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "spot_translations", ["locale"], name: "index_spot_translations_on_locale", using: :btree
  add_index "spot_translations", ["spot_id"], name: "index_spot_translations_on_spot_id", using: :btree

  create_table "spots", force: true do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "slug"
    t.string   "image"
    t.integer  "image_size",         limit: 8
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.integer  "creator_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  add_index "spots", ["place_id"], name: "index_spots_on_place_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",                            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
