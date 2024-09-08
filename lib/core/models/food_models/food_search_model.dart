/*
 
 */

class FoodSearchModel {
  static const String Search = 'search';
  static const String Latest = 'latest';
  static const String Category = 'category';

  static const String OrderDesc = 'desc';
  static const String OrderAsc = 'asc';
  static const String OrderByDate = 'date';
  static const String OrderById = 'id';
  static const String OrderByInclude = 'include';
  static const String OrderByTitle = 'title';
  static const String OrderBySlug = 'slug';
  static const String StatusAny = 'any';
  static const String StatusDraft = 'draft';
  static const String StatusPending = 'pending';
  static const String StatusPrivate = 'private';
  static const String StatusPublish = 'publish';
  static const String TypeGrouped = 'grouped';
  static const String TypeSimple = 'simple';
  static const String TypeExternal = 'external';
  static const String TypeVariable = 'variable';
  static const String StockStatusInStock = 'instock';
  static const String StockStatusOutOfStock = 'outofstock';
  static const String StockStatusOnBackOrder = 'onbackorder';

  int page;
  int perPage = 12;
  String search;
  String after;
  String before;
  List<int> exclude;
  List<int> include;
  int offset;
  String order = 'desc';
  String orderBy = 'date';
  List<int> parent;
  List<int> parentExclude;
  String slug;
  String status = 'publish';
  String sku;
  bool featured;
  String category;
  String tag;
  String shippingClass;
  String attribute;
  String attributeTerm;
  bool onSale;
  String minPrice;
  String maxPrice;
  String stockStatus;

  FoodSearchModel();

  FoodSearchModel.set({
    this.page = 1,
    this.perPage = 12,
    this.search,
    this.after,
    this.before,
    this.exclude,
    this.include,
    this.offset,
    this.order,
    this.orderBy,
    this.parent,
    this.parentExclude,
    this.slug,
    this.status,
    this.sku,
    this.featured,
    this.category,
    this.tag,
    this.shippingClass,
    this.attribute,
    this.attributeTerm,
    this.onSale,
    this.minPrice,
    this.maxPrice,
    this.stockStatus,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'per_page': perPage,
        'search': search,
        'after': after,
        'before': before,
        'exclude': exclude,
        'include': include,
        'offset': offset,
        'order': order,
        'orderby': orderBy,
        'parent': parent,
        'parent_exclude': parentExclude,
        'slug': slug,
        'status': status,
        'sku': sku,
        'featured': featured,
        'category': category,
        'tag': tag,
        'shipping_class': shippingClass,
        'attribute': attribute,
        'attribute_term': attributeTerm,
        'on_sale': onSale,
        'min_price': minPrice,
        'max_price': maxPrice,
        'stock_status': stockStatus,
      };

  String toQuery() =>
      '?page=$page&per_page=$perPage&search=$search&exclude=$exclude&include=$include&order=$order&orderby=$orderBy&parent=$parent&parent_exclude=$parentExclude&slug=$slug&status=$status&sku=$sku&featured=$featured&category=$category&tag=$tag&shipping_class=$shippingClass&attribute=$attribute&attribute_term=$attributeTerm&on_sale=$onSale&min_price=$minPrice&max_price=$maxPrice&stock_status=$stockStatus';

  FoodSearchModel.search({
    this.page = 1,
    this.perPage = 12,
    this.search,
    this.order = OrderDesc,
    this.orderBy = OrderByDate,
    this.status = StatusPublish,
    this.sku = '',
  });

  String searchQuery() =>
      '?page=$page&per_page=$perPage&search=$search&order=$order&orderby=$orderBy&status=$status&sku=$sku';

  FoodSearchModel.latest({
    this.page = 1,
    this.perPage = 12,
    this.order = OrderDesc,
    this.orderBy = OrderByDate,
    this.status = StatusPublish,
  });

  String latestQuery() =>
      '?page=$page&per_page=$perPage&order=$order&orderby=$orderBy&status=$status';

  FoodSearchModel.category({
    this.page = 1,
    this.perPage = 12,
    this.category,
    this.order = OrderDesc,
    this.orderBy = OrderByDate,
    this.status = StatusPublish,
  });

  String categoryQuery() =>
      '?page=$page&per_page=$perPage&category=$category&order=$order&orderby=$orderBy&status=$status';

  FoodSearchModel.searchAndCategory({
    this.page = 1,
    this.perPage = 12,
    this.category,
    this.search,
    this.order = OrderDesc,
    this.orderBy = OrderByDate,
    this.status = StatusPublish,
  });

  String searchAndCategoryQuery() =>
      '?page=$page&per_page=$perPage&category=$category&search=$search&order=$order&orderby=$orderBy&status=$status';

  FoodSearchModel.include(
      {this.page = 1,
      this.perPage = 12,
      this.order = OrderDesc,
      this.orderBy = OrderByDate,
      this.status = StatusPublish,
      this.include});

  String includeQuery() =>
      '?page=$page&per_page=$perPage&order=$order&orderby=$orderBy&status=$status&include=${include.join(',').toString()}';
}
