import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_shop/constants/color_constants.dart';
import 'package:demo_shop/utility/widgets/custom_button.dart';
import 'package:demo_shop/utility/widgets/sized_box_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/product_dm.dart';

class ProductDetailUI extends StatelessWidget {
  final ProductDm productDm;
  const ProductDetailUI({Key? key, required this.productDm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_checkout_outlined,
                color: Colors.white),
            onPressed: () {
              context.pushNamed('cart_list');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImage(),
            size16H,
            Expanded(child: productDetails()),
          ],
        ),
      ),
    );
  }

  Widget productImage() {
    return Hero(
      tag: '${productDm.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl: productDm.image!,
          height: 300,
          width: double.infinity,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget productDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            productDm.title ?? '',
            maxLines: 4,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          size10H,
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                productDm.description ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          size10H,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                'Rating : ${productDm.rating!.rate}/5 (${productDm.rating!.count})',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          ),
          size16H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 160,
                  child: CustomButton(
                    onPress: () {},
                    text: 'Add To Cart',
                    textSize: 16,
                  )),
              Text(
                'Price: \$${productDm.price}',
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
