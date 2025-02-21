import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_products_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/get_cart_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/remove_cart_products.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit() : super(CartProductsLoading());

  void displayCartProducts() async {
    var returnedData = await serviceLocator<GetCartProductsUseCase>().call();

    returnedData.fold((error) {
      emit(LoadCartProductsFailure(errorMessage: error));
    }, (data) {
      emit(CartProductsLoaded(products: data));
    });
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
    emit(CartProductsLoading());
    var returnedData = await serviceLocator<RemoveCartProductUseCase>()
        .call(params: product.id);

    returnedData.fold((error) {
      emit(LoadCartProductsFailure(errorMessage: error));
    }, (data) {
      displayCartProducts();
    });
  }
}
