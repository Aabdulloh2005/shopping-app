import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/viewmodels/product_viewmodel.dart';
import 'package:online_shop/views/widgets/home_widget.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  ProductViewmodel productViewmodel;
  Function(Product) onFavoriteTapped;
  Function(Product) onCartTapped;

  SearchViewDelegate({
    required this.onCartTapped,
    required this.onFavoriteTapped,
    required this.productViewmodel,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return HomeWidget(
      query: query,
      onCartTapped: onCartTapped,
      onFavoriteTapped: onFavoriteTapped,
      productViewmodel: productViewmodel,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return HomeWidget(
        query: query,
        onCartTapped: onCartTapped,
        onFavoriteTapped: onFavoriteTapped,
        productViewmodel: productViewmodel);
  }
}
