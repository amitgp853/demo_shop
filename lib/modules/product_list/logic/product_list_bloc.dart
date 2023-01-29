import 'package:bloc/bloc.dart';
import 'package:demo_shop/modules/product_list/repository/product_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/product_dm.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepo productRepo = ProductRepo();
  List<ProductDm> productList = [];

  ProductListBloc() : super(ProductListInitial()) {
    on<GetProductList>((event, emit) async {
      emit(ProductListLoading());
      try {
        productList = await productRepo.fetchProductList(
            limit: event.limit, category: event.category);
        List<ProductDm> productDmList = productRepo.searchProducts(
            productList: productList, searchText: event.searchString);
        emit(ProductListLoaded(productList: productDmList));
      } catch (e) {
        debugPrint('Error while fetching products: ${e.toString()}');
        emit(ProductListFailed());
      }
    });
    on<GetCategoryList>((event, emit) async {
      try {
        List<String> categoryList = await productRepo.getCategories();
        emit(CategoryListLoaded(categoryList: categoryList));
      } catch (e) {
        debugPrint('Error while fetching products: ${e.toString()}');
        emit(CategoryListFailed());
      }
    });
    on<SearchProductFromList>((event, emit) async {
      try {
        List<ProductDm> productDmList = productRepo.searchProducts(
            productList: productList, searchText: event.searchString);
        emit(ProductListLoaded(productList: productDmList));
      } catch (e) {
        debugPrint('Error while searching products: ${e.toString()}');
        emit(ProductListFailed());
      }
    });
  }
}
