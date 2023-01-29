part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class GetProductList extends ProductListEvent {
  final int limit;
  final String? category;
  final String searchString;
  final bool checkReachMax;
  final bool refreshCalled;
  GetProductList(
      {required this.limit,
      this.category,
      required this.searchString,
      this.refreshCalled = false,
      this.checkReachMax = false});
}

class GetCategoryList extends ProductListEvent {}

class SearchProductFromList extends ProductListEvent {
  final String searchString;
  SearchProductFromList({this.searchString = ''});
}
