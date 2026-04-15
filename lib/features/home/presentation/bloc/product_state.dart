import 'package:equatable/equatable.dart';

import '../../data/product_model.dart';

abstract class ProductState extends Equatable{
  List<Object?> get props => [];
}

class ProductLoading extends ProductState{}

class ProductLoaded extends ProductState{
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState{}