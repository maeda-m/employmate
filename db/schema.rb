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

ActiveRecord::Schema[7.0].define(version: 2023_05_01_115534) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "survey_id", null: false
    t.datetime "created_at", null: false
    t.index ["survey_id"], name: "index_answers_on_survey_id"
    t.index ["user_id", "survey_id"], name: "index_answers_on_user_id_and_survey_id", unique: true
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "unemployed_on"
    t.boolean "recommended_to_extension_of_benefit_receivable_period", default: false
    t.boolean "recommended_to_public_vocational_training", default: false
    t.boolean "unemployed_with_special_eligible", default: false
    t.boolean "unemployed_with_special_reason", default: false
    t.date "explanitory_seminar_on_for_employment_insurance"
    t.date "first_unemployment_certification_on"
    t.string "week_type_for_unemployment_certification"
    t.string "day_of_week_for_unemployment_certification"
    t.string "reason_code_for_loss_of_employment"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "questionnaires", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "title"
    t.integer "position", null: false
    t.index ["survey_id"], name: "index_questionnaires_on_survey_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "questionnaire_id", null: false
    t.string "body"
    t.string "answer_component_type", null: false
    t.boolean "required", default: false
    t.integer "position", null: false
    t.string "answer_gateway_rule"
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "google_id"
    t.datetime "created_at", null: false
  end

  add_foreign_key "answers", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "questionnaires"
end
