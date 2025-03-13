import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_favorite_state_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/toggle_favorite_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class ToggleFavoriteCubit extends Cubit<bool> {
  ToggleFavoriteCubit() : super(false);

  void isFavorite(String productID) async {
    var result = await serviceLocator<GetFavoriteStateUseCase>().call(
      params: productID,
    );
    emit(result);
  }

  void onTap(ProductEntity product) async {
    var result = await serviceLocator<ToggleFavoriteUseCase>().call(
      params: product,
    );
    result.fold(
      (left) {},
      (right) {
        emit(right);
      },
    );
  }
}
