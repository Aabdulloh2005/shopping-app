import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final Function(Product) onFavoriteTapped;
  ProductDetailPage({
    super.key,
    required this.onFavoriteTapped,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              widget.onFavoriteTapped(widget.product);
              setState(() {});
            },
            icon: widget.product.isFavorite
                ? const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red,
                  )
                : const Icon(CupertinoIcons.heart),
          ),
        ],
        title: Text(widget.product.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
              )),
          const SizedBox(height: 10),
          Text(
            widget.product.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Price: ${widget.product.price}\$",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
        ],
      ),
      
    );
  }
}
