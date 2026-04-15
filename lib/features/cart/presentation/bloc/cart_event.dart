import 'package:equatable/equatable.dart';

import '../../../home/data/product_model.dart';

abstract class CartEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent{
  final Product product;

  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}
