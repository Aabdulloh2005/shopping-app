import 'package:online_shop/models/product.dart';
import 'package:online_shop/services/product_http_service.dart';

class ProductViewmodel {
  ProductHttpService productHttpService = ProductHttpService();
  List<Product> _list = [];

  Future<List<Product>> get list async {
    _list = await productHttpService.getProducts();

    return _list;
  }

  Future<void> updateProduct(Product product) async {
    await productHttpService.updateProduct(product);

  }

  Future<void> addProduct(
    String title,
    String imageUrl,
    double price,
    int amount,
  ) async {
    await productHttpService.addProduct(title, imageUrl, price, amount);
  }

  List<Product> _cartList = [];

  Future<List<Product>> get cartList async {
    // _cartList = await productHttpService.getProducts();

    return _cartList;
  }

  Future<void> onDeleteTapped(int index) async {
    _cartList.removeAt(index);
  }

  Future<void> addToCard(Product product) async {
    _cartList.add(product);
  }

  List<Product> _savedList = [];

  Future<List<Product>> get savedList async {
    // _savedList = await productHttpService.getProducts();

    return _savedList;
  }


}
