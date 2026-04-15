import 'package:equatable/equatable.dart';

import '../../../home/data/product_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final int index;

  RemoveFromCart(this.index);

  @override
  List<Object?> get props => [index];
}

class ClearCart extends CartEvent {}
