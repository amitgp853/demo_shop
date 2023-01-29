part of 'product_list_bloc.dart';

@immutable
abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductDm> productList;
  ProductListLoaded({required this.productList});
}

class ProductListFailed extends ProductListState {}

class CategoryListLoaded extends ProductListState {
  final List<String> categoryList;
  CategoryListLoaded({required this.categoryList});
}

class CategoryListFailed extends ProductListState {}
