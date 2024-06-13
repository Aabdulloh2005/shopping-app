import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/viewmodels/product_viewmodel.dart';
import 'package:online_shop/views/widgets/card_page_widget.dart';
import 'package:online_shop/views/widgets/custom_drawer.dart';
import 'package:online_shop/views/widgets/home_widget.dart';
import 'package:online_shop/views/widgets/saved_page_widget.dart';
import 'package:online_shop/views/widgets/search_view_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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

  void onDeleteTapped(int index) async {
    await productViewmodel.onDeleteTapped(index);
    setState(() {});
  }

  void onCartTapped(Product product) async {
    await productViewmodel.addToCard(product);
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
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchViewDelegate(
                    onCartTapped: onCartTapped,
                    onFavoriteTapped: onFavoriteTapped,
                    productViewmodel: productViewmodel,
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.appHome),
        ),
        body: [
          HomeWidget(
              onCartTapped: onCartTapped,
              onFavoriteTapped: onFavoriteTapped,
              productViewmodel: productViewmodel),
          CardPageWidget(
              onDeleteTapped: onDeleteTapped,
              onFavoriteTapped: onFavoriteTapped,
              productViewmodel: productViewmodel),
          SavedPageWidget(
            onCartTapped: onCartTapped,
            onFavoriteTapped: onFavoriteTapped,
            productViewmodel: productViewmodel,
          ),
          const Text("profile"),
        ][pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.amber,
          selectedItemColor: Colors.amber,
          onTap: (value) {
            pageIndex = value;
            setState(() {});
          },
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: AppLocalizations.of(context)!.appHome),
            BottomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.cart,
                ),
                label: AppLocalizations.of(context)!.appCart),
            BottomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.heart,
                ),
                label: AppLocalizations.of(context)!.appSaved),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.person,
                ),
                label: AppLocalizations.of(context)!.appProfile),
          ],
        ),
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
        drawer: const CustomDrawer());
  }
}
