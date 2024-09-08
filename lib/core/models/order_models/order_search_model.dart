/*
 
 */

class OrderSearchModel {
  static const String Search = 'search';
  static const String Latest = 'latest';
  static const String Category = 'category';

  static const String OrderDesc = 'desc';
  static const String OrderAsc = 'asc';
  static const String OrderByDate = 'date';
  static const String OrderById = 'id';
  static const String OrderByTitle = 'title';
  static const String OrderBySlug = 'slug';
  static const String StatusAny = 'any';
  static const String StatusProcessing = 'processing';
  static const String StatusPending = 'pending';
  static const String StatusOnHold = 'on-hold';
  static const String StatusCompleted = 'completed';
  static const String StatusCancelled = 'cancelled';
  static const String StatusRefunded = 'refunded';
  static const String StatusFailed = 'failed';
  static const String StatusTrash = 'trash';

  int page;
  int perPage = 12;
  String search;
  String order = 'desc';
  String orderBy = 'date';
  String status = 'any';
  int customer;

  OrderSearchModel();

  OrderSearchModel.create({
    this.page = 1,
    this.perPage = 12,
    this.search,
    this.order,
    this.orderBy,
    this.status,
    this.customer,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'per_page': perPage,
        'search': search,
        'order': order,
        'orderby': orderBy,
        'status': status,
        'customer': customer,
      };

  String toQuery() =>
      '?page=$page&per_page=$perPage&search=$search&order=$order&orderby=$orderBy&status=$status&customer=$customer';

  OrderSearchModel.search({
    this.page = 1,
    this.perPage = 100,
    this.search,
    this.order = OrderDesc,
    this.orderBy = OrderByDate,
    this.status = StatusAny,
    this.customer,
  });

  String searchQuery() =>
      '?page=$page&per_page=$perPage&search=$search&order=$order&orderby=$orderBy&status=$status&customer=$customer';

  OrderSearchModel.customer(
      {this.page = 1,
      this.perPage = 100,
      this.order = OrderDesc,
      this.orderBy = OrderByDate,
      this.status = StatusAny,
      this.customer});

  String customerQuery() =>
      '?page=$page&per_page=$perPage&order=$order&orderby=$orderBy&status=$status&customer=$customer';
}
