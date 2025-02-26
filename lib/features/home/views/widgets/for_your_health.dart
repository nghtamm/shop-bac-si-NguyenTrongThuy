import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/news_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/news_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/news_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/entities/news.dart';

class ForYourHealth extends StatelessWidget {
  const ForYourHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewDisplayCubit()..displayNews(),
      child: BlocBuilder<NewDisplayCubit, NewsDisplayState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsLoaded) {
            return _news(state.news);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _news(List<NewEntity> news) {
    return SizedBox(
      height: 330.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          return NewsCard(newEntity: news[index]);
        },
      ),
    );
  }
}
