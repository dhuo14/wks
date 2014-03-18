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

ActiveRecord::Schema.define(version: 20140314072733) do

  create_table "areas", force: true do |t|
    t.string   "name",           comment: "单位名称"
    t.string   "ancestry",       comment: "祖先节点"
    t.integer  "ancestry_depth", comment: "层级"
    t.string   "code",           comment: "编号"
    t.integer  "sort",           comment: "排序"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name",                                                  comment: "单位名称"
    t.string   "ancestry",                                              comment: "祖先节点"
    t.integer  "ancestry_depth",                                        comment: "层级"
    t.integer  "status",         limit: 2, default: 0,     null: false, comment: "状态"
    t.string   "short_name",                                            comment: "单位简称"
    t.string   "org_code",                                              comment: "组织机构代码"
    t.string   "legal_name",                                            comment: "单位法人姓名"
    t.string   "legal_number",                                          comment: "单位法人身份证"
    t.integer  "area_id",                                               comment: "地区id"
    t.string   "address",                                               comment: "详细地址"
    t.string   "post_code",                                             comment: "邮编"
    t.string   "website",                                               comment: "公司网址"
    t.string   "domain",                                                comment: "店铺域名"
    t.string   "bank",                                                  comment: "开户银行"
    t.string   "bank_code",                                             comment: "银行帐号"
    t.string   "industry",                                              comment: "行业类别"
    t.string   "cgr_nature",                                            comment: "单位性质"
    t.string   "gys_nature",                                            comment: "公司性质"
    t.string   "capital",                                               comment: "注册资金"
    t.string   "license",                                               comment: "营业执照"
    t.string   "tax",                                                   comment: "税务登记证"
    t.string   "employee",                                              comment: "职工人数"
    t.string   "turnover",                                              comment: "年营业额"
    t.string   "tel",                                                   comment: "电话（总机）"
    t.string   "fax",                                                   comment: "传真"
    t.string   "lng",                                                   comment: "经度"
    t.string   "lat",                                                   comment: "纬度"
    t.text     "summary",                                               comment: "单位介绍"
    t.boolean  "is_secret",                default: false, null: false, comment: "是否保密单位"
    t.boolean  "is_blacklist",             default: false, null: false, comment: "是否在黑名单中"
    t.integer  "sort",                                                  comment: "排序号"
    t.text     "details",                                               comment: "明细"
    t.text     "logs",                                                  comment: "日志"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["ancestry"], name: "index_departments_on_ancestry", using: :btree
  add_index "departments", ["name"], name: "index_departments_on_name", unique: true, using: :btree
  add_index "departments", ["org_code"], name: "index_departments_on_org_code", unique: true, using: :btree

  create_table "icons", force: true do |t|
    t.string  "name",                                 null: false, comment: "名称"
    t.string  "ancestry",                                          comment: "祖先节点"
    t.integer "ancestry_depth",                                    comment: "层级"
    t.string  "transfer",                                          comment: "实际图标，父级节点的name不是真正的图标"
    t.integer "status",         limit: 2, default: 0, null: false, comment: "状态"
    t.integer "sort",                                              comment: "排序"
  end

  add_index "icons", ["name"], name: "index_icons_on_name", unique: true, using: :btree

  create_table "menus", force: true do |t|
    t.string   "name",                                 null: false, comment: "名称"
    t.string   "ancestry",                                          comment: "祖先节点"
    t.integer  "ancestry_depth",                                    comment: "层级"
    t.string   "icon",                                              comment: "图标"
    t.string   "url",                                               comment: "url"
    t.integer  "status",         limit: 2, default: 0, null: false, comment: "状态"
    t.integer  "sort",                                              comment: "排序"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.integer  "department_id",                default: 0,                  comment: "单位id"
    t.string   "login",                                        null: false, comment: "登录名"
    t.string   "password",                                     null: false, comment: "登录名"
    t.string   "name",                                         null: false, comment: "姓名"
    t.string   "portrait",                                                  comment: "头像"
    t.string   "gender",             limit: 2,                              comment: "性别"
    t.string   "identity_num",                                              comment: "身份证"
    t.string   "identity_pic",                                              comment: "身份证图片"
    t.string   "email",                                                     comment: "电子邮箱"
    t.string   "mobile",                                                    comment: "手机"
    t.boolean  "is_visible",                   default: true,  null: false, comment: "是否公开,目前仅指身份证和手机号"
    t.string   "tel",                                                       comment: "电话"
    t.string   "fax",                                                       comment: "传真"
    t.boolean  "is_admin",                     default: false, null: false, comment: "是否管理员"
    t.integer  "status",                       default: 0,     null: false, comment: "状态"
    t.string   "duty",                                                      comment: "职务"
    t.string   "professional_title",                                        comment: "职称"
    t.text     "details",                                                   comment: "明细"
    t.text     "logs",                                                      comment: "日志"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree

end
