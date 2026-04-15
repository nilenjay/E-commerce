import 'package:ecommerce_app/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/pages/product_detail_screen.dart';


final GoRouter router = GoRouter(
  initialLocation: '/home',
    routes: [
      GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
          path: '/detail',
          builder: (context, state) => ProductDetailScreen(),

      )

    ],

);

