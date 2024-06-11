import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/viewmodels/product_viewmodel.dart';
import 'package:online_shop/services/product_http_service.dart';
import 'package:online_shop/views/widgets/home_widget.dart';
import 'package:online_shop/views/widgets/product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  ProductViewmodel productViewmodel = ProductViewmodel();
  int pageIndex = 0;
  String? title, price, amount, imageUrl;

  void onFavoriteTapped(Product product) async {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
    await productViewmodel.updateProduct(product);
  }

  void onAddTapped() async {
    final data = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, {
                    "title": title,
                    "imageUrl": imageUrl,
                    "price": price,
                    'amount': amount,
                  });
                }
              },
              child: const Text("Save"),
            ),
          ],
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter title";
                    }
                    title = value;
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Price",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter price";
                    }
                    price = value;
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter amount";
                    }
                    amount = value;
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: "iamgeUrl",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter image";
                    }
                    imageUrl = value;
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    if (data != null) {
      productViewmodel.addProduct(
        data['title'],
        data['imageUrl'],
        double.parse(data["price"]),
        int.parse(data['amount']),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
        title: const Text("Home Page"),
      ),
      body: [
        HomeWidget(
            onFavoriteTapped: onFavoriteTapped,
            productViewmodel: productViewmodel),
        Text("cart"),
        Text("profile"),
      ][pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            pageIndex = value;
            setState(() {});
          },
          currentIndex: pageIndex,
          fixedColor: Colors.amber,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "home"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.cart,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile")
          ]),
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: onAddTapped,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
