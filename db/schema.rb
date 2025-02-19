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

ActiveRecord::Schema[7.0].define(version: 2022_05_27_032836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "repositories", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "table of github repositories", force: :cascade do |t|
    t.integer "repository_id", null: false
    t.string "name", null: false
    t.string "full_name", null: false
    t.boolean "private", default: false, null: false
    t.string "html_url", null: false
    t.string "description"
    t.string "fork", default: "f", null: false
    t.string "forks_url"
    t.string "git_url"
    t.string "ssh_url"
    t.string "clone_url"
    t.string "language"
    t.boolean "allow_forking", default: true, null: false
    t.integer "forks_count"
    t.string "visibility", null: false
    t.string "default_branch", null: false
    t.uuid "user_id", null: false, comment: "user reference column"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_repositories_on_repository_id", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "table of github users", force: :cascade do |t|
    t.string "login", null: false
    t.bigint "github_id", null: false
    t.string "url", null: false
    t.string "name", null: false
    t.string "email"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["github_id"], name: "index_users_on_github_id", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  add_foreign_key "repositories", "users"
end
