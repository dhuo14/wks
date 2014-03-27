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

ActiveRecord::Schema.define(version: 20140327033502) do

  create_table "areas", force: true do |t|
    t.string   "name",           comment: "单位名称"
    t.string   "ancestry",       comment: "祖先节点"
    t.integer  "ancestry_depth", comment: "层级"
    t.string   "code",           comment: "编号"
    t.integer  "sort",           comment: "排序"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_categories", force: true do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  add_index "article_categories", ["article_id", "category_id"], name: "index_article_categories_on_article_id_and_category_id", using: :btree

  create_table "article_contents", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.integer  "article_content_id"
    t.string   "title",                                        comment: "标题"
    t.integer  "user_id",                         null: false, comment: "发布者ID"
    t.integer  "article_category_id",             null: false, comment: "类别ID"
    t.datetime "publish_time",                                 comment: "发布时间"
    t.string   "tags",                                         comment: "标签"
    t.integer  "new_days",            default: 3, null: false, comment: "几天内显示new标签"
    t.integer  "top_type",            default: 0, null: false, comment: "置顶类别"
    t.integer  "access_permission",   default: 0, null: false, comment: "访问权限"
    t.integer  "status",              default: 0, null: false, comment: "状态"
    t.text     "content",                                      comment: "内容"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["tags"], name: "index_articles_on_tags", using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name",                                 null: false, comment: "名称"
    t.string   "ancestry",                                          comment: "祖先节点"
    t.integer  "ancestry_depth",                                    comment: "层级"
    t.string   "icon",                                              comment: "图标"
    t.integer  "status",         limit: 2, default: 0, null: false, comment: "状态"
    t.integer  "sort",                                              comment: "排序"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "departments", force: true do |t|
    t.string   "name",                                     null: false, comment: "单位名称"
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
    t.string   "route_path",                                        comment: "url"
    t.integer  "status",         limit: 2, default: 0, null: false, comment: "状态"
    t.integer  "sort",                                              comment: "排序"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["name"], name: "index_menus_on_name", unique: true, using: :btree

  create_table "menus_users", force: true do |t|
    t.integer "user_id", null: false
    t.integer "menu_id", null: false
  end

  add_index "menus_users", ["user_id", "menu_id"], name: "index_menus_users_on_user_id_and_menu_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "sender_id",                                      null: false, comment: "发送者ID"
    t.integer  "receiver_id",                                    null: false, comment: "接收者ID"
    t.integer  "notification_category_id",                       null: false, comment: "类别ID"
    t.string   "title",                                                       comment: "标题"
    t.string   "content",                                                     comment: "内容"
    t.integer  "status",                   limit: 2, default: 0, null: false, comment: "状态"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id", using: :btree

  create_table "uploads", force: true do |t|
    t.integer  "article_id",        comment: "文章ID"
    t.string   "data_file_name",    comment: "文件名"
    t.string   "data_content_type", comment: "文件类型"
    t.string   "data_file_size",    comment: "文件大小"
    t.datetime "data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uploads", ["article_id"], name: "index_uploads_on_article_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "department_id",                 default: 0,                  comment: "单位id"
    t.string   "login",                                                      comment: "登录名"
    t.string   "password_digest",                               null: false, comment: "密码"
    t.string   "remember_token",                                             comment: "自动登录"
    t.string   "name",                                                       comment: "姓名"
    t.string   "birthday",           limit: 10,                              comment: "出生日期"
    t.string   "portrait",                                                   comment: "头像"
    t.string   "gender",             limit: 2,                               comment: "性别"
    t.string   "identity_num",                                               comment: "身份证"
    t.string   "identity_pic",                                               comment: "身份证图片"
    t.string   "email",                                         null: false, comment: "电子邮箱"
    t.string   "mobile",                                                     comment: "手机"
    t.boolean  "is_visible",                    default: true,  null: false, comment: "是否公开,目前仅指身份证和手机号"
    t.string   "tel",                                                        comment: "电话"
    t.string   "fax",                                                        comment: "传真"
    t.boolean  "is_admin",                      default: false, null: false, comment: "是否管理员"
    t.integer  "status",                        default: 0,     null: false, comment: "状态"
    t.string   "duty",                                                       comment: "职务"
    t.string   "professional_title",                                         comment: "职称"
    t.text     "bio",                                                        comment: "个人简历"
    t.text     "details",                                                    comment: "明细"
    t.text     "logs",                                                       comment: "日志"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree

end
