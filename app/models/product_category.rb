# -*- encoding : utf-8 -*-
class ProductCategory < Category
  default_scope -> {where(["ancestry LIKE ? OR ancestry = ? ",'2/%',2])}
end