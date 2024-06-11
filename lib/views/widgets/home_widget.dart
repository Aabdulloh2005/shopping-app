import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/viewmodels/product_viewmodel.dart';
import 'package:online_shop/views/widgets/product_widget.dart';

class HomeWidget extends StatefulWidget {
  ProductViewmodel productViewmodel;
  Function(Product) onFavoriteTapped;
  HomeWidget(
      {required this.onFavoriteTapped,
      required this.productViewmodel,
      super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.productViewmodel.list,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("Apida muammo bor"),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Apida error keldi"),
          );
        }

        final data = snapshot.data;
        return data == null || data.isEmpty
            ? const CircularProgressIndicator()
            : GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) {
                  final product = data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              product: product,
                              onFavoriteTapped: widget.onFavoriteTapped),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onFavoriteTapped(product);
                                  },
                                  child: product.isFavorite
                                      ? const Icon(
                                          CupertinoIcons.heart_fill,
                                          color: Colors.red,
                                          size: 25,
                                        )
                                      : const Icon(
                                          CupertinoIcons.heart,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Text(product.title),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${product.price}\$",
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        CupertinoIcons.shopping_cart))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
