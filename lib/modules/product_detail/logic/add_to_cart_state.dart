part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddingToCart extends AddToCartState {}

class NotAddedToCart extends AddToCartState {}

class AddedToCart extends AddToCartState {}

class AddingToCartFailed extends AddToCartState {}
