import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/product_dm.dart';

class ProductWidget extends StatelessWidget {
  final ProductDm productDm;
  final VoidCallback onTap;
  const ProductWidget({Key? key, required this.productDm, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Hero(
                tag: '${productDm.id}',
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
              const SizedBox(
                height: 16,
              ),
              Text(
                productDm.title ?? '',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                productDm.description ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Price: \$${productDm.price}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
