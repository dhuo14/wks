# -*- encoding : utf-8 -*-

class Department < ActiveRecord::Base

  has_ancestry :cache_depth => true
  
end
