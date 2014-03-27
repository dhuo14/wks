# -*- encoding : utf-8 -*-
class Menu < ActiveRecord::Base
	has_many :user_menus, dependent: :destroy
  has_many :users, :through => :user_menus, :source => :user
  # 树形结构
  has_ancestry :cache_depth => true
  default_scope -> {order(:ancestry, :sort, :id)}

  def parent_name
  end

  private

end
