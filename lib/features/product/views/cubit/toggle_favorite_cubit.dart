import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_favorite_state_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/favorite_bloc.dart';

// class ToggleFavoriteCubit extends Cubit<bool> {
//   ToggleFavoriteCubit() : super(false);

//   void isFavorite(String productID) async {
//       await serviceLocator<GetFavoriteStateUseCase>().call(
//       params: {'productID': productID},
//     );
//   }
// }

class ToggleFavoriteCubit extends Cubit<bool> {
  ToggleFavoriteCubit() : super(false);

  void isFavorite(String productID, FavoriteBloc favoriteBloc) {
    final isFavorite = favoriteBloc.state is FavoriteLoaded &&
        (favoriteBloc.state as FavoriteLoaded)
            .favorites
            .any((favorite) => favorite.productID.toString() == productID);
    emit(isFavorite);
  }
}