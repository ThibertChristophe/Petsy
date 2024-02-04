# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_04_210120) do
  create_table "pets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.date "birthday"
    t.bigint "user_id"
    t.bigint "species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "avatar"
    t.index ["species_id"], name: "index_pets_on_species_id"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "pets_posts", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.bigint "post_id", null: false
    t.index ["pet_id", "post_id"], name: "index_pets_posts_on_pet_id_and_post_id"
    t.index ["post_id", "pet_id"], name: "index_pets_posts_on_post_id_and_pet_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "species", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "pets_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.boolean "confirm", default: false
    t.string "confirmation_token"
    t.string "password_digest"
    t.string "firstname"
    t.string "lastname"
    t.boolean "avatar", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recover_password"
  end

  add_foreign_key "pets", "species"
  add_foreign_key "pets", "users"
  add_foreign_key "posts", "users"
end
