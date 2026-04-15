import 'package:equatable/equatable.dart';

import '../../../home/data/product_model.dart';

class CartState extends Equatable{
  final List<Product> cartItems;

  CartState(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}