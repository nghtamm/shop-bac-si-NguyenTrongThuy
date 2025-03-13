import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/add_to_cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/dispose_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/get_cart_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/remove_cart_products.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartDisplayed>(_onCartDisplayed);
    on<CartProductRemoved>(_onCartProductRemoved);
    on<CartDisposed>(_onCartDisposed);
    on<CartProductAdded>(_onCartProductAdded);
  }

  Future<void> _onCartDisplayed(
      CartDisplayed event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());

      var data = await serviceLocator<GetCartProductsUseCase>().call();
      await data.fold(
        (left) async {
          emit(CartLoadFailure(message: left));
        },
        (right) async {
          emit(CartLoaded(products: right));
        },
      );
    } catch (error) {
      emit(CartLoadFailure(message: error.toString()));
    }
  }

  Future<void> _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());

      var data = await serviceLocator<RemoveCartProductUseCase>().call(
        params: event.productID,
      );

      await data.fold(
        (left) async {
          emit(CartLoadFailure(message: left));
        },
        (right) async {
          await _onCartDisplayed(CartDisplayed(), emit);
        },
      );
    } catch (error) {
      emit(CartLoadFailure(message: error.toString()));
    }
  }

  Future<void> _onCartDisposed(
      CartDisposed event, Emitter<CartState> emit) async {
    try {
      var data = await serviceLocator<DisposeCartUseCase>().call();

      await data.fold(
        (left) async {
          emit(CartLoadFailure(message: left));
        },
        (right) async {
          emit(CartDisposedSuccess(displayName: event.displayName));
        },
      );
    } catch (error) {
      emit(CartLoadFailure(message: error.toString()));
    }
  }

  Future<void> _onCartProductAdded(
      CartProductAdded event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());

      var data = await serviceLocator<AddToCartUseCase>().call(
        params: event.requirements,
      );

      await data.fold(
        (left) async {
          emit(CartProductAddFailure(message: left));
        },
        (right) async {
          emit(CartProductAddSuccess(message: right));
        },
      );
    } catch (error) {
      emit(CartProductAddFailure(message: error.toString()));
    }
  }
}
