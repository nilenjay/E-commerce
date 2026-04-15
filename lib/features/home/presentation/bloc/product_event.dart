import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable{
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent{}
