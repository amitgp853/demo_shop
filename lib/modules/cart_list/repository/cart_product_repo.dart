import '../../../models/product_dm.dart';
import '../../../utility/helpers/local_db.dart';

class CartProductRepo {
  LocalDb localDb = LocalDb();

  List<ProductDm> getCartProducts({required int userId}) {
    List<ProductDm> productDmList = localDb.getData(userId);
    return productDmList;
  }

  void addToCart({required ProductDm productDm, required int userId}) {
    localDb.writeData(productDm, userId);
  }

  bool checkIfAdded({required ProductDm productDm, required int userId}) {
    return localDb.checkIfPresent(productDm, userId);
  }

  void deleteFromCart({required ProductDm productDm, required int userId}) {
    localDb.delete(productDm, userId);
  }
}
