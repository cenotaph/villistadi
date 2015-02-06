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

ActiveRecord::Schema.define(version: 20150206142031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true, using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
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

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.boolean  "published"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type", limit: 255
    t.integer  "commentable_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title",           limit: 255
    t.string   "address1",        limit: 255
    t.string   "city",            limit: 255
    t.string   "postcode",        limit: 255
    t.string   "venue",           limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "description"
    t.string   "contact_name",    limit: 255
    t.string   "contact_contact", limit: 255
    t.boolean  "approved",                                             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "latitude",                    precision: 10, scale: 6
    t.decimal  "longitude",                   precision: 10, scale: 6
    t.string   "address2",        limit: 255
    t.string   "weblink",         limit: 255
    t.integer  "eventtype_id"
    t.string   "slug",            limit: 255
  end

  add_index "events", ["project_id"], name: "index_events_on_project_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "eventtype_translations", force: :cascade do |t|
    t.integer  "eventtype_id",             null: false
    t.string   "locale",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",         limit: 255
  end

  add_index "eventtype_translations", ["eventtype_id"], name: "index_eventtype_translations_on_eventtype_id", using: :btree
  add_index "eventtype_translations", ["locale"], name: "index_eventtype_translations_on_locale", using: :btree

  create_table "eventtypes", force: :cascade do |t|
    t.string   "colour_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forumposts", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title",      limit: 255
    t.text     "body"
    t.boolean  "sticky"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forumposts", ["project_id"], name: "index_forumposts_on_project_id", using: :btree
  add_index "forumposts", ["user_id"], name: "index_forumposts_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "internallink_translations", force: :cascade do |t|
    t.integer  "internallink_id",             null: false
    t.string   "locale",          limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name",    limit: 255
  end

  add_index "internallink_translations", ["internallink_id"], name: "index_internallink_translations_on_internallink_id", using: :btree
  add_index "internallink_translations", ["locale"], name: "index_internallink_translations_on_locale", using: :btree

  create_table "internallinks", force: :cascade do |t|
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.string   "parameter",  limit: 255
    t.string   "name",       limit: 255
    t.boolean  "published"
    t.string   "custom_url", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_hierarchies", force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "menu_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "menu_anc_desc_udx", unique: true, using: :btree
  add_index "menu_hierarchies", ["descendant_id"], name: "menu_desc_idx", using: :btree

  create_table "menu_translations", force: :cascade do |t|
    t.integer  "menu_id",                  null: false
    t.string   "locale",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name", limit: 255
  end

  add_index "menu_translations", ["locale"], name: "index_menu_translations_on_locale", using: :btree
  add_index "menu_translations", ["menu_id"], name: "index_menu_translations_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "item_type",  limit: 255
    t.integer  "item_id"
    t.integer  "parent_id"
    t.integer  "sort_order"
    t.boolean  "published"
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["city_id"], name: "index_menus_on_city_id", using: :btree

  create_table "page_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "page_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "page_anc_desc_udx", unique: true, using: :btree
  add_index "page_hierarchies", ["descendant_id"], name: "page_desc_idx", using: :btree

  create_table "page_translations", force: :cascade do |t|
    t.integer  "page_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
    t.text     "body"
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "slug",       limit: 255
    t.boolean  "published"
    t.integer  "city_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["city_id"], name: "index_pages_on_city_id", using: :btree

  create_table "photo_translations", force: :cascade do |t|
    t.integer  "photo_id",               null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      limit: 255
  end

  add_index "photo_translations", ["locale"], name: "index_photo_translations_on_locale", using: :btree
  add_index "photo_translations", ["photo_id"], name: "index_photo_translations_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "image",              limit: 255
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type", limit: 255
    t.integer  "image_size"
    t.integer  "imageable_id"
    t.string   "imageable_type",     limit: 255
    t.string   "credit",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["imageable_id", "imageable_type"], name: "index_photos_on_imageable_id_and_imageable_type", using: :btree

  create_table "place_translations", force: :cascade do |t|
    t.integer  "place_id",                       null: false
    t.string   "locale",             limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",               limit: 255
    t.text     "description"
    t.text     "getting_there"
    t.text     "see_and_experience"
    t.text     "more_information"
    t.text     "facts"
    t.text     "future_of"
  end

  add_index "place_translations", ["locale"], name: "index_place_translations_on_locale", using: :btree
  add_index "place_translations", ["place_id"], name: "index_place_translations_on_place_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.integer  "city_id"
    t.decimal  "sw_lat",                              precision: 10, scale: 8
    t.decimal  "sw_lng",                              precision: 10, scale: 8
    t.decimal  "ne_lat",                              precision: 10, scale: 8
    t.decimal  "ne_lng",                              precision: 10, scale: 8
    t.string   "slug",                    limit: 255
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background",              limit: 255
    t.integer  "background_width"
    t.integer  "background_height"
    t.integer  "background_size",         limit: 8
    t.string   "background_content_type", limit: 255
    t.string   "pdf",                     limit: 255
    t.decimal  "centre_lat",                          precision: 10, scale: 8
    t.decimal  "centre_lng",                          precision: 10, scale: 8
  end

  add_index "places", ["city_id"], name: "index_places_on_city_id", using: :btree

  create_table "post_translations", force: :cascade do |t|
    t.integer  "post_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      limit: 255
    t.text     "body"
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "slug",              limit: 255
    t.string   "icon",              limit: 255
    t.integer  "icon_width"
    t.integer  "icon_height"
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_size",         limit: 8
    t.boolean  "published"
    t.datetime "published_at"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "posts", ["city_id"], name: "index_posts_on_city_id", using: :btree

  create_table "project_translations", force: :cascade do |t|
    t.integer  "project_id",              null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.text     "tagline"
    t.text     "description"
  end

  add_index "project_translations", ["locale"], name: "index_project_translations_on_locale", using: :btree
  add_index "project_translations", ["project_id"], name: "index_project_translations_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "slug",                            limit: 255
    t.boolean  "restricted_membership"
    t.boolean  "private"
    t.integer  "maximum_members"
    t.boolean  "has_forum"
    t.boolean  "members_can_create_forum_topics"
    t.boolean  "notify_admin_of_new_member"
    t.integer  "owner_id"
    t.string   "image",                           limit: 255
    t.integer  "image_size",                      limit: 8
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                                    default: false, null: false
  end

  add_index "projects", ["archived"], name: "index_projects_on_archived", using: :btree

  create_table "projects_users", force: :cascade do |t|
    t.integer "project_id",                     null: false
    t.integer "user_id",                        null: false
    t.boolean "is_admin"
    t.boolean "receive_emails"
    t.boolean "pending"
    t.boolean "denied",         default: false, null: false
  end

  add_index "projects_users", ["project_id", "user_id"], name: "by_project_and_user", unique: true, using: :btree
  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id", using: :btree
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id", using: :btree

  create_table "randombackgrounds", force: :cascade do |t|
    t.boolean  "active"
    t.string   "background",              limit: 255
    t.integer  "background_size"
    t.integer  "background_width"
    t.integer  "background_height"
    t.string   "background_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "spot_translations", force: :cascade do |t|
    t.integer  "spot_id",                 null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.text     "description"
  end

  add_index "spot_translations", ["locale"], name: "index_spot_translations_on_locale", using: :btree
  add_index "spot_translations", ["spot_id"], name: "index_spot_translations_on_spot_id", using: :btree

  create_table "spots", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "slug",               limit: 255
    t.string   "image",              limit: 255
    t.integer  "image_size",         limit: 8
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type", limit: 255
    t.integer  "creator_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  add_index "spots", ["place_id"], name: "index_spots_on_place_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "username",               limit: 255,              null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "slug",                   limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
