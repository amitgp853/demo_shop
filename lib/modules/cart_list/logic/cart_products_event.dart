part of 'cart_products_bloc.dart';

@immutable
abstract class CartProductsEvent {}

class GetCartProducts extends CartProductsEvent {}

class RemoveFromCart extends CartProductsEvent {
  final ProductDm productDm;
  RemoveFromCart({required this.productDm});
}
