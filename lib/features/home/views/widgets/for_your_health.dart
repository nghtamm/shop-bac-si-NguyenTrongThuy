import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/news_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/news_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/news_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/entities/news.dart';
=======
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/home_news_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/home_news_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/entities/news.dart';
>>>>>>> nghtamm2003/refactor

class ForYourHealth extends StatelessWidget {
  const ForYourHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNewsBloc()..add(NewsDisplayed()),
      child: BlocBuilder<HomeNewsBloc, HomeNewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsLoaded) {
            return _fyhNews(
              state.news,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _fyhNews(List<NewEntity> news) {
    return SizedBox(
      height: 330.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          return HomeNewsCard(
            newEntity: news[index],
          );
        },
      ),
    );
  }
}
