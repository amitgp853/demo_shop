import '../../../models/product_dm.dart';
import '../../../utility/helpers/local_db.dart';

class CartProductRepo {
  LocalDb localDb = LocalDb();

  Future<List<ProductDm>> getCartProducts() async {
    List<ProductDm> productDmList = await localDb.getData();
    return productDmList;
  }

  Future<void> addToCart({required ProductDm productDm}) async {
    await localDb.writeData(productDm);
  }

  bool checkIfAdded({required ProductDm productDm}) {
    return localDb.checkIfPresent(productDm);
  }

  Future<void> deleteFromCart({required ProductDm productDm}) async {
    await localDb.delete(productDm);
  }
}
