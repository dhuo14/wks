# -*- encoding : utf-8 -*-
class ArticleCategory < Category
  default_scope -> {descendants_of(Category.find(2))}
end