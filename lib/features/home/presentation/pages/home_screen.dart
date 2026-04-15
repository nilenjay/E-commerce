import 'package:ecommerce_app/features/home/presentation/widgets/banner_slider.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/category_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../banner_mock_data.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProducts()),

      child: Scaffold(
        appBar: AppBar(title: Text('E-Commerce App'),
          actions: [
            Padding(padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.search),
            ),
          ],
        ),

        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            }

            else if (state is ProductLoaded) {
              return Column(
                children: [
                  BannerSlider(banners: banners),

                  SizedBox(height: 10,),

                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                  ),

                  CategoryList(),

                  SizedBox(height: 10,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Popular Products",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            }

            else {
              return Center(child: Text('Error occured during loading'));
            }
          },
        ),
      ),
    );
  }
}
