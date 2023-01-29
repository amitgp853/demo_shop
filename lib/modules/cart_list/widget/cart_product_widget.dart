import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_shop/models/product_dm.dart';
import 'package:demo_shop/modules/cart_list/logic/cart_products_bloc.dart';
import 'package:demo_shop/utility/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: productDm.image!,
                      height: 120,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300] ?? Colors.white,
                        highlightColor: Colors.grey[100] ?? Colors.white,
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                size16W,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productDm.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        productDm.description ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            size16H,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Price: \$${productDm.price}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPress: () {
                      cartProductsBloc
                          .add(RemoveFromCart(productDm: productDm));
                    },
                    text: 'Remove From Cart',
                    textSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
