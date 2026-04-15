import 'package:flutter/material.dart';

import '../../data/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Image.network(
            product.image,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.broken_image);
            },
          ),
          SizedBox(height: 10),
          Text(product.name),
          Text("₹${product.price}"),
        ],
      ),
    );
  }
}