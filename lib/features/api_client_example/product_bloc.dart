import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_use_case.dart';

// Events
abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {}

// States
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<ProductModel> products;

  ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String errorMessage;

  ProductErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<FetchProductsEvent>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());

    try {
      final result = await serviceLocator<ProductUseCase>().call();

      result.fold(
        (error) => emit(ProductErrorState(error)),
        (products) => emit(ProductLoadedState(products)),
      );
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
