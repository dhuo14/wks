# -*- encoding : utf-8 -*-
class ArticleCategory < Category
  default_scope -> {where(["ancestry LIKE ? OR ancestry = ? ",'1/%',1])}
end