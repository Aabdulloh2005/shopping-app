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
}
