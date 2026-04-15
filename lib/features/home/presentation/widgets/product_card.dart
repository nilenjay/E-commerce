import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../data/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/detail',extra: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
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
                ),
              ),

              SizedBox(height: 8),

              Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 4),

              Text(
                "₹${product.price}",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Container(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {context.read<CartBloc>().add(AddToCart(product));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product.name} added to cart")),
                  );},
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
