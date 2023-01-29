part of 'cart_products_bloc.dart';

@immutable
abstract class CartProductsState {}

class CartProductsInitial extends CartProductsState {}

class CartProductsLoading extends CartProductsState {}

class CartProductsLoaded extends CartProductsState {
  final List<ProductDm> cartProducts;
  CartProductsLoaded({required this.cartProducts});
}

class CartProductsLoadingFailed extends CartProductsState {}
