import 'package:bloc/bloc.dart';
import 'package:demo_shop/models/product_dm.dart';
import 'package:demo_shop/modules/cart_list/repository/cart_product_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  CartProductRepo cartProductRepo = CartProductRepo();

  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddToCart>((event, emit) {
      emit(AddingToCart());
      try {
        cartProductRepo.addToCart(productDm: event.productDm);
        emit(AddedToCart());
      } catch (e) {
        debugPrint('Error while adding to cart: ${e.toString()}');
        emit(AddingToCartFailed());
      }
    });
    on<CheckIfAdded>((event, emit) {
      emit(AddingToCart());
      try {
        if (cartProductRepo.checkIfAdded(productDm: event.productDm)) {
          emit(AddedToCart());
        } else {
          emit(NotAddedToCart());
        }
      } catch (e) {
        debugPrint('Error while check if it is added to cart: ${e.toString()}');
        emit(AddingToCartFailed());
      }
    });
  }
}
