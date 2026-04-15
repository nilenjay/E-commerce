import 'package:ecommerce_app/features/home/presentation/widgets/banner_slider.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../banner_mock_data.dart';
import '../../../../core/app_theme.dart';
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
        onPopInvokedWithResult: (didPop, result) {
          final now = DateTime.now();
          if (lastBackPressed == null ||
              now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
            lastBackPressed = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Press back again to exit"),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Text('E-Commerce App'),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () => context.push('/cart'),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Badge(
                        isLabelVisible: state.cartItems.isNotEmpty,
                        label: Text(
                          state.cartItems.length.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: AppTheme.error,
                        child: const Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primary,
                    strokeWidth: 3,
                  ),
                );
              } else if (state is ProductLoaded) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      BannerSlider(banners: banners),
                      const SizedBox(height: 20),
                      _buildSectionHeader("Categories", ""),
                      const SizedBox(height: 8),
                      CategoryList(),
                      const SizedBox(height: 20),
                      _buildSectionHeader(
                        "Popular Products",
                        "${state.products.length} items",
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(product: state.products[index]);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 56,
                        color: AppTheme.textMuted,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Something went wrong',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Please try again later',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppTheme.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          if (trailing.isNotEmpty)
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}