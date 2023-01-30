import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/product_dm.dart';

class LocalDb {
  //Initialize the instance for hive box
  var myBox = Hive.box('cart_products');

  //Method for writing data in the database
  void writeData(ProductDm productDm, int userId) {
    myBox.put('$userId-${productDm.id}', [
      productDm.id,
      productDm.title,
      productDm.description,
      productDm.image,
      productDm.price
    ]);
  }

  //Method to get the list of entries in database
  List<ProductDm> getData(int userId) {
    debugPrint('Length of products: ${myBox.length}');
    List<ProductDm> productDmList = [];

    for (var key in myBox.keys) {
      if (key.toString().contains('$userId-')) {
        var value = myBox.get(key);
        productDmList.add(ProductDm(
            id: value[0],
            title: value[1],
            description: value[2],
            image: value[3],
            price: value[4]));
      }
    }
    return productDmList;
  }

  //Method to check if the key is present in database
  bool checkIfPresent(ProductDm productDm, int userId) {
    bool isPresent = myBox.containsKey('$userId-${productDm.id}');
    debugPrint('Check present $userId-${productDm.id} $isPresent');
    return isPresent;
  }

  //Method to get the length of database
  int dbLength(int userId) {
    return myBox.keys
        .where((key) => key.toString().contains('$userId-'))
        .toList()
        .length;
  }

  //Method to get the stream to regularly listen to changes in database
  Stream changesInDB() {
    return myBox.watch();
  }

  //Method to delete the entry from the database
  void delete(ProductDm productDm, int userId) {
    myBox.delete('$userId-${productDm.id}');
    debugPrint('Product deleted with id: $userId-${productDm.id}');
  }
}
