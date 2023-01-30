import 'package:demo_shop/modules/cart_list/logic/cart_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../models/product_dm.dart';
import '../../../utility/widgets/sized_box_widgets.dart';
import '../widget/cart_product_widget.dart';

class CartListUI extends StatefulWidget {
  const CartListUI({Key? key}) : super(key: key);

  @override
  State<CartListUI> createState() => _CartListUIState();
}

class _CartListUIState extends State<CartListUI> {
  late final CartProductsBloc cartProductsBloc;

  //list of cart product shown
  List<ProductDm> cartProducts = [];

  @override
  void initState() {
    super.initState();
    cartProductsBloc = CartProductsBloc();
    cartProductsBloc.add(GetCartProducts());
  }

  @override
  void dispose() {
    cartProductsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(cart),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: BlocBuilder(
          bloc: cartProductsBloc,
          builder: (context, state) {
            if (state is CartProductsLoaded) {
              cartProducts = state.cartProducts;
            }
            if (cartProducts.isEmpty) {
              return noProductFound();
            }
            return getProductList(cartProducts: cartProducts);
          },
        ),
      ),
    );
  }

  Widget noProductFound() {
    return const Center(
      child: Text(
        noProductInCart,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget getProductList({required List<ProductDm> cartProducts}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  return CartProductWidget(
                    productDm: cartProducts[index],
                    cartProductsBloc: cartProductsBloc,
                  );
                }),
          ),
          size10H,
          getTotalPriceWidget(cartProducts: cartProducts),
        ],
      ),
    );
  }

  Widget getTotalPriceWidget({required List<ProductDm> cartProducts}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            totalPrice,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          size6W,
          Text('\$${getTotalPrice(productList: cartProducts)}',
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red))
        ],
      ),
    );
  }

  //to get the total price that is sum of all the products in cart
  String getTotalPrice({required List<ProductDm> productList}) {
    num sum = 0;
    for (var product in productList) {
      sum = sum + product.price!;
    }
    return sum.toStringAsFixed(2);
  }
}
