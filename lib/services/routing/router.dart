import 'package:demo_shop/modules/cart_list/ui/cart_list_ui.dart';
import 'package:demo_shop/modules/product_detail/ui/product_detail_ui.dart';
import 'package:demo_shop/modules/product_list/ui/product_list_ui.dart';
import 'package:demo_shop/services/routing/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../models/product_dm.dart';
import '../../modules/login/ui/login_ui.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: homeScreenName,
      path: homeScreenPath,
      builder: (context, state) => LoginUI(),
    ),
    GoRoute(
      name: productListScreenName,
      path: productListScreenPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: ProductListUI(),
      ),
    ),
    GoRoute(
      name: productDetailScreenName,
      path: productDetailScreenPath,
      pageBuilder: (context, state) => CupertinoPage(
        child: ProductDetailUI(
          productDm: state.extra as ProductDm,
        ),
      ),
    ),
    GoRoute(
      name: cartListScreenName,
      path: cartListScreenPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: CartListUI(),
      ),
    ),
  ],
);
