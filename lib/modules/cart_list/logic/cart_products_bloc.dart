import 'package:bloc/bloc.dart';
import 'package:demo_shop/models/product_dm.dart';
import 'package:demo_shop/services/singleton/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/user_dm.dart';
import '../repository/cart_product_repo.dart';

part 'cart_products_event.dart';
part 'cart_products_state.dart';

class CartProductsBloc extends Bloc<CartProductsEvent, CartProductsState> {
  CartProductRepo cartProductRepo = CartProductRepo();
  UserDm? currentUser = UserSingleton.getCurrentUserDm();

  CartProductsBloc() : super(CartProductsInitial()) {
    List<ProductDm> cartProducts = [];

    on<GetCartProducts>((event, emit) async {
      emit(CartProductsLoading());
      try {
        cartProducts =
            cartProductRepo.getCartProducts(userId: currentUser!.id!);
        emit(CartProductsLoaded(cartProducts: cartProducts));
      } catch (e) {
        debugPrint('Error while getting cart products: ${e.toString()}');
        emit(CartProductsLoadingFailed());
      }
    });

    on<RemoveFromCart>((event, emit) async {
      emit(CartProductsLoading());
      try {
        cartProductRepo.deleteFromCart(
            productDm: event.productDm, userId: currentUser!.id!);
        cartProducts =
            cartProductRepo.getCartProducts(userId: currentUser!.id!);
        emit(CartProductsLoaded(cartProducts: cartProducts));
      } catch (e) {
        debugPrint('Error while removing cart products: ${e.toString()}');
        emit(CartProductsLoadingFailed());
      }
    });
  }
}
