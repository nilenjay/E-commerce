import 'package:ecommerce_app/features/home/presentation/widgets/banner_slider.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../banner_mock_data.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProducts()),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          final now = DateTime.now();

          if (lastBackPressed == null ||
              now.difference(lastBackPressed!) > Duration(seconds: 2)) {
            lastBackPressed = now;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Press back again to exit")),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('E-Commerce App'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.push('/cart');
                          },
                          child: Stack(
                            children: [
                              Icon(Icons.shopping_cart),
                            ],
                          ),
                        ),

                        if (state.cartItems.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text(
                                state.cartItems.length.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                return Column(
                  children: [
                    BannerSlider(banners: banners),

                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    CategoryList(),

                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Popular Products",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: state.products.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Error occurred during loading'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}