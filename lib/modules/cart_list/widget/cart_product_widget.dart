import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_shop/models/product_dm.dart';
import 'package:demo_shop/modules/cart_list/logic/cart_products_bloc.dart';
import 'package:demo_shop/utility/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../constants/string_constants.dart';
import '../../../utility/widgets/sized_box_widgets.dart';

class CartProductWidget extends StatelessWidget {
  final ProductDm productDm;
  final CartProductsBloc cartProductsBloc;
  const CartProductWidget(
      {Key? key, required this.productDm, required this.cartProductsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            productImageAndDetailsRow(),
            size16H,
            productPriceAndButtonRow(),
          ],
        ),
      ),
    );
  }

  Widget productImageAndDetailsRow() {
    return Row(
      children: [
        productImage(),
        size16W,
        productDetails(),
      ],
    );
  }

  Widget productImage() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl: productDm.image!,
          height: 120,
          fit: BoxFit.fitHeight,
          placeholder: (context, url) => Container(),
        ),
      ),
    );
  }

  Widget productDetails() {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productDm.title ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          size12H,
          Text(
            productDm.description ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget productPriceAndButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [productPrice(), removeFromCartButton()],
    );
  }

  Widget productPrice() {
    return Expanded(
      child: Text(
        '$price\$${productDm.price}',
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget removeFromCartButton() {
    return Expanded(
      child: CustomButton(
        onPress: () {
          cartProductsBloc.add(RemoveFromCart(productDm: productDm));
        },
        text: removeFromCart,
        textSize: 12,
      ),
    );
  }
}
