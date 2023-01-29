import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/product_dm.dart';

class LocalDb {
  var myBox = Hive.box('cart_products');

  Future<void> initializeHive() async {
    //initialize hive
    Hive.initFlutter();

    //open the box
    await Hive.openBox('cart_products');
  }

  writeData(ProductDm productDm) {
    myBox.put(productDm.id, [
      productDm.id,
      productDm.title,
      productDm.description,
      productDm.image,
      productDm.price
    ]);
  }

  getData() {
    debugPrint('Length of products: ${myBox.length}');
    List<ProductDm> productDmList = [];
    for (var value in myBox.values) {
      productDmList.add(ProductDm(
          id: value[0],
          title: value[1],
          description: value[2],
          image: value[3],
          price: value[4]));
    }
    return productDmList;
  }

  bool checkIfPresent(ProductDm productDm) {
    bool isPresent = myBox.containsKey(productDm.id);
    debugPrint('Check present ${productDm.id} $isPresent');
    return isPresent;
  }

  int dbLength() {
    return myBox.values.length;
  }

  Stream changesInDB() {
    return myBox.watch();
  }

  delete(ProductDm productDm) {
    myBox.delete(productDm.id);
    debugPrint('Product deleted with id: ${productDm.id}');
  }
}
