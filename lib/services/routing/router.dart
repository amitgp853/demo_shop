import 'package:demo_shop/modules/cart_list/ui/cart_list_ui.dart';
import 'package:demo_shop/modules/product_detail/ui/product_detail_ui.dart';
import 'package:demo_shop/modules/product_list/ui/product_list_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../models/product_dm.dart';
import '../../modules/login/ui/login_ui.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => LoginUI(),
    ),
    GoRoute(
      name: 'product_list',
      path: '/product_list',
      pageBuilder: (context, state) => const CupertinoPage(
        child: ProductListUI(),
      ),
    ),
    GoRoute(
      name: 'product',
      path: '/product',
      pageBuilder: (context, state) => CupertinoPage(
        child: ProductDetailUI(
          productDm: state.extra as ProductDm,
        ),
      ),
    ),
    GoRoute(
      name: 'cart_list',
      path: '/cart_list',
      pageBuilder: (context, state) => const CupertinoPage(
        child: CartListUI(),
      ),
    ),
  ],
);
