import 'dart:convert';

import 'package:online_shop/models/product.dart';
import 'package:http/http.dart' as http;

class ProductHttpService {
  Future<List<Product>> getProducts() async {
    String uri =
        "https://online-shop-b18bf-default-rtdb.firebaseio.com/products.json";

    Uri url = Uri.parse(uri);

    final response = await http.get(url);

    final data = await jsonDecode(response.body);

    List<Product> loadedProducts = [];
    data.forEach((key, val) {
      val['id'] = key;
      print(key);
      loadedProducts.add(Product.fromJson(val));
    });

    return loadedProducts;
  }

  Future<void> updateProduct(Product product) async {
    Uri url = Uri.parse(
        "https://online-shop-b18bf-default-rtdb.firebaseio.com/products/${product.id}.json");
    Map<String, dynamic> productData = {
      "title": product.title,
      "imageUrl": product.imageUrl,
      "price": product.price,
      'amount': product.amount,
      'isFavorite': product.isFavorite,
    };
    final response = await http.patch(
      url,
      body: jsonEncode(productData),
    );

    // if (response.statusCode == 200) {
    //   print("Qoshildi");
    // } else {
    //   print("Error keldi");
    // }
  }

  Future<void> addProduct(
    String title,
    String imageUrl,
    double price,
    int amount,
  ) async {
    Uri url = Uri.parse(
        "https://online-shop-b18bf-default-rtdb.firebaseio.com/products.json");

    if (!imageUrl.contains("https:")) {
      imageUrl =
          "https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg";
    }
    Map<String, dynamic> productData = {
      "title": title,
      "imageUrl": imageUrl,
      "price": price,
      'amount': amount,
      'isFavorite': false,
    };

    final response = await http.post(
      url,
      body: jsonEncode(productData),
    );
  }
}
