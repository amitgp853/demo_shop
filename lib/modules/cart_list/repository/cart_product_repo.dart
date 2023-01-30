import '../../../models/product_dm.dart';
import '../../../utility/helpers/local_db.dart';

class CartProductRepo {
  LocalDb localDb = LocalDb();

  List<ProductDm> getCartProducts() {
    List<ProductDm> productDmList = localDb.getData();
    return productDmList;
  }

  void addToCart({required ProductDm productDm}) {
    localDb.writeData(productDm);
  }

  bool checkIfAdded({required ProductDm productDm}) {
    return localDb.checkIfPresent(productDm);
  }

  void deleteFromCart({required ProductDm productDm}) {
    localDb.delete(productDm);
  }
}
