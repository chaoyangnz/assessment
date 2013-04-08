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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130313074015) do

  create_table "choices", :force => true do |t|
    t.string  "content",   :null => false
    t.string  "weight"
    t.boolean "is_answer"
    t.integer "node_id",   :null => false
  end

  create_table "invitations", :force => true do |t|
    t.string   "code",         :null => false
    t.string   "status"
    t.integer  "used_by"
    t.datetime "used_at"
    t.integer  "organizer_id", :null => false
  end

  create_table "nodes", :force => true do |t|
    t.string  "type",     :default => "question", :null => false
    t.string  "media",    :default => "text",     :null => false
    t.string  "content",                          :null => false
    t.integer "depth"
    t.integer "weight"
    t.string  "pattern"
    t.string  "answer"
    t.integer "grade"
    t.integer "paper_id",                         :null => false
    t.integer "node_id"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.string   "address"
    t.string   "telephone"
    t.string   "linkman"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "organizations", ["name"], :name => "index_organizations_on_name", :unique => true

  create_table "papers", :force => true do |t|
    t.string   "type",       :default => "general", :null => false
    t.string   "name",                              :null => false
    t.string   "notice"
    t.integer  "score"
    t.integer  "duration"
    t.string   "created_by"
    t.datetime "created_at"
    t.boolean  "has_parts"
    t.string   "language"
    t.string   "purpose"
    t.string   "status"
    t.integer  "paper_id"
  end

  create_table "test", :force => true do |t|
    t.string   "mode",          :null => false
    t.integer  "score"
    t.string   "status"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "finish_reason"
    t.integer  "user_id"
    t.integer  "paper_id"
    t.integer  "part_id"
  end

  create_table "test_details", :force => true do |t|
    t.boolean "mark_flag"
    t.integer "test_id"
    t.integer "question_id"
    t.integer "choice_id"
  end

  create_table "uploads", :force => true do |t|
    t.string   "file"
    t.string   "type"
    t.string   "original_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "role"
    t.string   "username"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",                     :default => 0
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "organization_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
