import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

abstract class ProductDisplayState {}

class ProductInitialState extends ProductDisplayState {}

class ProductLoading extends ProductDisplayState {}

class ProductLoaded extends ProductDisplayState {
  final List<ProductEntity> products;

  ProductLoaded({required this.products});
}

class ProductLoadFailed extends ProductDisplayState {}
