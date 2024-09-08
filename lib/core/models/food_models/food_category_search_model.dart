/*
 
 */

class FoodCategorySearchModel {
  static const String OrderDesc = 'desc';
  static const String OrderAsc = 'asc';
  static const String OrderById = 'id';
  static const String OrderByInclude = 'include';
  static const String OrderByName = 'name';
  static const String OrderBySlug = 'slug';
  static const String OrderByTermGroup = 'term_group';
  static const String OrderByDescription = 'description';
  static const String OrderByCount = 'count';

  int page;
  int perPage = 12;
  String search;
  List<int> exclude;
  List<int> include;
  String order = 'desc';
  String orderBy = 'date';
  bool hideEmpty;
  int parent;
  int food;
  String slug;

  FoodCategorySearchModel();

  FoodCategorySearchModel.set({
    this.page,
    this.perPage,
    this.search,
    this.exclude,
    this.include,
    this.order,
    this.orderBy,
    this.hideEmpty,
    this.parent,
    this.food,
    this.slug,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'per_page': perPage,
        'search': search,
        'exclude': exclude,
        'include': include,
        'order': order,
        'order_by': orderBy,
        'hide_empty': hideEmpty,
        'parent': parent,
        'food': food,
        'slug': slug,
      };

  FoodCategorySearchModel.search({
    this.page = 1,
    this.perPage = 12,
    this.search,
    this.order = OrderDesc,
    this.orderBy = OrderByName,
  });

  String searchQuery() =>
      '?page=$page&per_page=$perPage&search=$search&order=$order&orderby=$orderBy&hide_empty=true';

  FoodCategorySearchModel.all({
    this.page = 1,
    this.perPage = 12,
    this.order = OrderDesc,
    this.orderBy = OrderByCount,
  });

  String allQuery() =>
      '?page=$page&per_page=$perPage&order=$order&orderby=$orderBy&hide_empty=true';

  FoodCategorySearchModel.child({
    this.page = 1,
    this.perPage = 12,
    this.order = OrderDesc,
    this.orderBy = OrderByName,
    this.parent,
  });

  String childQuery() =>
      '?page=$page&per_page=$perPage&parent=$parent&order=$order&orderby=$orderBy&hide_empty=true';
}
