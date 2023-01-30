import 'package:badges/badges.dart' as badges;
import 'package:demo_shop/services/routing/routing_constants.dart';
import 'package:demo_shop/utility/helpers/local_db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartIconWidget extends StatelessWidget {
  CartIconWidget({Key? key}) : super(key: key);

  final LocalDb localDb = LocalDb();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: localDb.changesInDB(),
        builder: (ctx, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, right: 14.0),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              showBadge: localDb.dbLength() != 0,
              badgeContent: Text(
                '${localDb.dbLength()}',
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_checkout_outlined,
                    color: Colors.white),
                onPressed: () {
                  context.pushNamed(cartListScreenName);
                },
              ),
            ),
          );
        });
  }
}
