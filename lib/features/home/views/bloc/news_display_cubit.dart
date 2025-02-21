import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/news_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/usecase/get_news_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class NewDisplayCubit extends Cubit<NewsDisplayState> {
  NewDisplayCubit() : super(NewsInitialState());

  void displayNews({dynamic params}) async {
    var newsData = await serviceLocator<GetNewsUseCase>().call();
    newsData.fold(
      (left) {
        emit(NewsLoadFailed());
      },
      (right) {
        emit(NewsLoaded(news: right));
      },
    );
  }
}
