import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCart>((event, emit) {
      final updatedCart = List.of(state.cartItems)..add(event.product);
      emit(CartState(updatedCart));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedCart = List.of(state.cartItems)..removeAt(event.index);
      emit(CartState(updatedCart));
    });

    on<ClearCart>((event, emit) {
      emit(CartState([]));
    });
  }
}