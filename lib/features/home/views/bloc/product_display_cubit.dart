import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';

class ProductDisplayCubit extends Cubit<ProductDisplayState> {
  final UseCase useCase;

  ProductDisplayCubit({required this.useCase}) : super(ProductInitialState());

  void displayProducts({dynamic params}) async {
    emit(ProductLoading());

    var productData = await useCase.call(params: params);
    productData.fold(
      (left) {
        emit(ProductLoadFailed());
      },
      (right) {
        emit(ProductLoaded(products: right));
      },
    );
  }

  void displayInitial() {
    emit(ProductLoaded(products: []));
    emit(ProductInitialState());
  }
}
