import 'package:flutter/material.dart';

class CartListUI extends StatelessWidget {
  const CartListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(),
    );
  }
}
