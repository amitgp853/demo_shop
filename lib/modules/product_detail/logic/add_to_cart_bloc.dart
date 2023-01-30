import 'package:bloc/bloc.dart';
import 'package:demo_shop/models/product_dm.dart';
import 'package:demo_shop/modules/cart_list/repository/cart_product_repo.dart';
import 'package:demo_shop/services/singleton/user_singleton.dart';
import 'package:flutter/material.dart';

import '../../../models/user_dm.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  CartProductRepo cartProductRepo = CartProductRepo();
  UserDm? currentUser = UserSingleton.getCurrentUserDm();

  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddToCart>((event, emit) {
      emit(AddingToCart());
      try {
        cartProductRepo.addToCart(
            productDm: event.productDm, userId: currentUser!.id!);
        emit(AddedToCart());
      } catch (e) {
        debugPrint('Error while adding to cart: ${e.toString()}');
        emit(AddingToCartFailed());
      }
    });
    on<CheckIfAdded>((event, emit) {
      emit(AddingToCart());
      try {
        if (cartProductRepo.checkIfAdded(
            productDm: event.productDm, userId: currentUser!.id!)) {
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
