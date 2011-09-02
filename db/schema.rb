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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110830205031) do

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group_token"
  end

  create_table "journeys", :force => true do |t|
    t.integer  "start_mileage"
    t.integer  "end_mileage"
    t.integer  "user_id"
    t.integer  "group_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "journeys_users", :id => false, :force => true do |t|
    t.integer "journey_id"
    t.integer "user_id"
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.integer  "mileage"
  end

  create_table "payments_users", :id => false, :force => true do |t|
    t.integer "payment_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

end
