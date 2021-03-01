# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_01_073525) do

  create_table "if_thens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "if_then1", null: false
    t.text "if_then2", null: false
    t.text "if_then3"
    t.bigint "user_id"
    t.bigint "objective_id"
    t.bigint "small_step_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["objective_id"], name: "index_if_thens_on_objective_id"
    t.index ["small_step_id"], name: "index_if_thens_on_small_step_id"
    t.index ["user_id"], name: "index_if_thens_on_user_id"
  end

  create_table "objectives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "big_area", null: false
    t.text "text", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_objectives_on_user_id"
  end

  create_table "small_steps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "small_step1", null: false
    t.text "small_step2", null: false
    t.text "small_step3", null: false
    t.text "small_step4"
    t.text "small_step5"
    t.bigint "user_id"
    t.bigint "objective_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["objective_id"], name: "index_small_steps_on_objective_id"
    t.index ["user_id"], name: "index_small_steps_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "if_thens", "objectives"
  add_foreign_key "if_thens", "small_steps"
  add_foreign_key "if_thens", "users"
  add_foreign_key "objectives", "users"
  add_foreign_key "small_steps", "objectives"
  add_foreign_key "small_steps", "users"
end
