import 'package:badges/badges.dart' as badges;
import 'package:demo_shop/services/routing/routing_constants.dart';
import 'package:demo_shop/services/singleton/user_singleton.dart';
import 'package:demo_shop/utility/helpers/local_db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/user_dm.dart';

class CartIconWidget extends StatelessWidget {
  CartIconWidget({Key? key}) : super(key: key);

  final LocalDb localDb = LocalDb();
  final UserDm? currentUser = UserSingleton.getCurrentUserDm();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: localDb.changesInDB(),
        builder: (ctx, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, right: 14.0),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              showBadge: localDb.dbLength(currentUser!.id!) != 0,
              badgeContent: Text(
                '${localDb.dbLength(currentUser!.id!)}',
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
