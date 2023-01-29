part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class GetProductList extends ProductListEvent {
  final int limit;
  final String? category;
  final String searchString;
  GetProductList(
      {required this.limit, this.category, required this.searchString});
}

class GetCategoryList extends ProductListEvent {}

class SearchProductFromList extends ProductListEvent {
  final String searchString;
  SearchProductFromList({this.searchString = ''});
}
