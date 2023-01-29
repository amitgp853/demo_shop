import 'package:dio/dio.dart';

import '../../../models/product_dm.dart';
import '../../../utility/helpers/network_call.dart';

class ProductRepo {
  Future<List<ProductDm>> fetchProductList(
      {required int limit, String? category}) async {
    List<ProductDm> productDmList = [];
    var productList = [];
    Dio netCall = await NetworkCall.getDio();
    Response response = await netCall.get(
        'products${category != null && category != '' ? '/category/$category' : ''}',
        queryParameters: {'limit': limit});

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

  Future<List<String>> getCategories() async {
    var categories = [];
    List<String> categoryList = [];
    Dio netCall = await NetworkCall.getDio();
    Response response = await netCall.get(
      'products/categories',
    );

    if (response.data != null) {
      categories = response.data;

      for (var category in categories) {
        categoryList.add(category.toString());
      }
    }
    return categoryList;
  }

  List<ProductDm> searchProducts(
      {required List<ProductDm> productList, required String searchText}) {
    List<ProductDm> productDmList = productList
        .where((product) =>
            product.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return productDmList;
  }
}
