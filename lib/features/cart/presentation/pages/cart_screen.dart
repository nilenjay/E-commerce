import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartBloc,CartState>(
          builder: (context,state){
            if(state.cartItems.isEmpty){
              return Center(
                child: Text('Your cart is empty'),
              );
            }
            return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context,index){
                  final product=state.cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(product.name),
                    subtitle: Text('₹${product.price}'),
                  );
                });
          }
      ),
    );
  }
}