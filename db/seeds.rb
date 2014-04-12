# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 初始化区域数据
if Area.first.blank?
  source = File.new("#{Rails.root}/db/sql/areas.sql", "r")
  line = source.gets
  ActiveRecord::Base.connection.execute(line)
  Area.rebuild_depth_cache!
end

if Department.first.blank?
  #User.delete_all
  [["执行机构","1"],["采购单位", "1"], ["供应商", "1"], ["监管机构", "1"], ["评审专家", "1"]].each do |option|
    Department.create(:name => option[0], :status => option[1])
  end
end

if Menu.first.blank?
  [["门户公告管理", "icon-home"],["党员信息管理",  "icon-sitemap"], ["互动交流平台",  "icon-comments"], ["协同办公系统", "icon-group"], ["远程教育平台",  "icon-globe"], ["移动办公平台",  "icon-mobile-phone"], ["系统设置",  "icon-cogs"]].each do |option|
    Menu.create(:name => option[0], :status => 1, :route_path => option[1])
  end
end

if Icon.first.blank?
  source = File.new("#{Rails.root}/db/sql/icons.sql", "r")
  line = source.gets
  ActiveRecord::Base.connection.execute(line)
  Icon.rebuild_depth_cache!
end

if Category.first.blank?
  a = Category.create(:name => "采购公告", :status => 1) 
  b = Category.create(:name => "日常公告", :status => 1) 
  ["招标公告","中标公告","竞价公告","询价公告"].each do |option|
    Category.create(:name => option, :status => 1, :parent => a)
  end
  ["重要通知","工作动态"].each do |option|
    Category.create(:name => option, :status => 1, :parent => b)
  end
end

if Role.first.blank?
  a = Role.create(:name => "监管平台", :status => 1) 
  b = Role.create(:name => "采购人平台", :status => 1) 
  ["系统管理员","部长","处长","经办人"].each do |option|
    Role.create(:name => option, :status => 1, :parent => a)
  end
  ["单位管理员","普通用户"].each do |option|
    Role.create(:name => option, :status => 1, :parent => b)
  end
end

if Permission.first.blank?
  [["manage", "department","单位管理"],["manage", "user","用户管理"],["manage",  "menu","菜单管理"],["manage","article","文章管理"], ["index","article","文章列表查看"]].each do |option|
    Permission.create(:action => option[0], :subject => option[1], :description => option[2])
  end
end