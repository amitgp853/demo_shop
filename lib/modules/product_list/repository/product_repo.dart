import 'package:demo_shop/constants/api_constants.dart';
import 'package:dio/dio.dart';

import '../../../models/product_dm.dart';
import '../../../utility/helpers/network_call.dart';

class ProductRepo {
  //Method to fetch the list of product from api
  Future<List<ProductDm>> fetchProductList(
      {required int limit, String? category}) async {
    List<ProductDm> productDmList = [];
    var productList = [];
    Dio netCall = await NetworkCall.getDio();
    Response response = await netCall.get(
        '$productPath${category != null && category != '' ? '$categoryPath$category' : ''}',
        queryParameters: {limitKey: limit});

    if (response.data != null) {
      productList = response.data;

      //Create the list from the response list
      for (var product in productList) {
        ProductDm productDm = ProductDm.fromJson(product);
        productDmList.add(productDm);
      }
    }
    return productDmList;
  }

  //Method to get the list of categories from api
  Future<List<String>> getCategories() async {
    var categories = [];
    List<String> categoryList = [];
    Dio netCall = await NetworkCall.getDio();
    Response response = await netCall.get(
      getCategoryPath,
    );

    if (response.data != null) {
      categories = response.data;

      for (var category in categories) {
        categoryList.add(category.toString());
      }
    }
    return categoryList;
  }

  //Method to search the product from search text
  List<ProductDm> searchProducts(
      {required List<ProductDm> productList, required String searchText}) {
    //To get the list matching the text to their product's title
    List<ProductDm> productDmList = productList
        .where((product) =>
            product.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return productDmList;
  }

  //Method to check the increase in length of list of products and tell if it reached max
  bool newProductLength(
      {required List<ProductDm> newProductList,
      required List<ProductDm> oldProductList}) {
    int length = newProductList.length - oldProductList.length;
    bool reachMax = false;
    if (length < 6) {
      reachMax = true;
    }
    return reachMax;
  }
}
