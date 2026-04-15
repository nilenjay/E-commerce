import 'package:ecommerce_app/features/home/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/home/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_mock_data.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(Duration(seconds: 2));

      try{
        emit(ProductLoaded(products));
      }
      catch(e){
        emit(ProductError());
      }
      }
    );
  }
}