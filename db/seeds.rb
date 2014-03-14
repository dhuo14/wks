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
  [["门户公告管理","1", "icon-home"],["党员信息管理", "1", "icon-sitemap"], ["互动交流平台", "1", "icon-comments"], ["协同办公系统", "1" ,"icon-group"], ["远程教育平台", "1", "icon-globe"], ["移动办公平台", "1", "icon-mobile-phone"], ["系统设置", "1", "icon-cogs"]].each do |option|
    Menu.create(:name => option[0], :status => option[1] , :url => option[2])
  end

end