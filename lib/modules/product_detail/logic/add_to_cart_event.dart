part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartEvent {}

class AddToCart extends AddToCartEvent {
  final ProductDm productDm;
  AddToCart({required this.productDm});
}

class CheckIfAdded extends AddToCartEvent {
  final ProductDm productDm;
  CheckIfAdded({required this.productDm});
}
