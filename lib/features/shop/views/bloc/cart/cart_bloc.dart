import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/add_to_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/dispose_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/display_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/remove_from_cart_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartProductAdded>(_onCartProductAdded);
    on<CartDisplayed>(_onCartDisplayed);
    on<CartProductRemoved>(_onCartProductRemoved);
    on<CartDisposed>(_onCartDisposed);
  }

  Future<void> _onCartProductAdded(
    CartProductAdded event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());

      await serviceLocator<AddToCartUseCase>().call(
        params: event.item,
      );

      final cart = serviceLocator<GlobalStorage>().cart ?? [];
      emit(
        CartLoaded(
          products: cart,
        ),
      );
    } catch (error) {
      emit(
        CartLoadFailure(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onCartDisplayed(
    CartDisplayed event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());

      final data = await serviceLocator<DisplayCartUseCase>().call();
      await data.fold(
        (left) async {
          emit(
            CartLoadFailure(
              message: left,
            ),
          );
        },
        (right) async {
          emit(
            CartLoaded(
              products: right,
            ),
          );
        },
      );
    } catch (error) {
      emit(
        CartLoadFailure(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());

      await serviceLocator<RemoveFromCartUseCase>().call(
        params: event.key,
      );

      final cart = serviceLocator<GlobalStorage>().cart ?? [];
      emit(
        CartLoaded(
          products: cart,
        ),
      );
    } catch (error) {
      emit(
        CartLoadFailure(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onCartDisposed(
    CartDisposed event,
    Emitter<CartState> emit,
  ) async {
    try {
      await serviceLocator<DisposeCartUseCase>().call();

      emit(
        CartLoaded(
          products: const [],
        ),
      );
    } catch (error) {
      emit(
        CartLoadFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
