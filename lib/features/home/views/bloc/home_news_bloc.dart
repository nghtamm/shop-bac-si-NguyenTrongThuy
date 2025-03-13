import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/entities/news.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/usecase/get_news_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

part 'home_news_event.dart';
part 'home_news_state.dart';

class HomeNewsBloc extends Bloc<HomeNewsEvent, HomeNewsState> {
  HomeNewsBloc() : super(NewsInitial()) {
    on<NewsDisplayed>(_onNewsDisplayed);
  }

  Future<void> _onNewsDisplayed(
      NewsDisplayed event, Emitter<HomeNewsState> emit) async {
    emit(NewsLoading());

    var data = await serviceLocator<GetNewsUseCase>().call();
    await data.fold(
      (left) async {
        emit(NewsLoadFailure());
      },
      (right) async {
        emit(NewsLoaded(news: right));
      },
    );
  }
}
