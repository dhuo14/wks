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

ActiveRecord::Schema.define(version: 20140224090300) do

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

end
