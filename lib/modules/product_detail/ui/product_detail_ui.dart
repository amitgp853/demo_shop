import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_shop/constants/color_constants.dart';
import 'package:demo_shop/modules/product_detail/logic/add_to_cart_bloc.dart';
import 'package:demo_shop/utility/widgets/custom_button.dart';
import 'package:demo_shop/utility/widgets/sized_box_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product_dm.dart';
import '../../../utility/helpers/local_db.dart';
import '../../../utility/widgets/cart_icon_widget.dart';

class ProductDetailUI extends StatefulWidget {
  final ProductDm productDm;

  const ProductDetailUI({Key? key, required this.productDm}) : super(key: key);

  @override
  State<ProductDetailUI> createState() => _ProductDetailUIState();
}

class _ProductDetailUIState extends State<ProductDetailUI> {
  final AddToCartBloc addToCartBloc = AddToCartBloc();
  final LocalDb localDb = LocalDb();

  @override
  void initState() {
    super.initState();
    addToCartBloc.add(CheckIfAdded(productDm: widget.productDm));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          CartIconWidget(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: productImage()),
            size16H,
            Expanded(child: productDetails()),
          ],
        ),
      ),
    );
  }

  Widget productImage() {
    return Hero(
      tag: '${widget.productDm.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl: widget.productDm.image!,
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
            widget.productDm.title ?? '',
            maxLines: 4,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          size10H,
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                widget.productDm.description ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          size10H,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                'Rating : ${widget.productDm.rating!.rate}/5 (${widget.productDm.rating!.count})',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ),
          size16H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addToCartButton(),
              Expanded(
                child: Text(
                  'Price: \$${widget.productDm.price}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget addToCartButton() {
    return Expanded(
      child: StreamBuilder(
        stream: localDb.changesInDB(),
        builder: (ctx, snapshot) {
          addToCartBloc.add(CheckIfAdded(productDm: widget.productDm));
          return BlocBuilder(
            bloc: addToCartBloc,
            builder: (context, state) {
              if (state is AddedToCart) {
                return CustomButton(
                  onPress: () {},
                  text: 'Added To Cart',
                  textSize: 15,
                  isOutline: true,
                );
              }
              return CustomButton(
                onPress: () {
                  addToCartBloc.add(AddToCart(productDm: widget.productDm));
                },
                text: 'Add To Cart',
                textSize: 15,
              );
            },
          );
        },
      ),
    );
  }
}
