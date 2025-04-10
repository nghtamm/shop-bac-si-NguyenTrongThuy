import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/models/videos_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/videos_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/home_videos_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/shimmer_loading.dart';

class ForYourHealth extends StatelessWidget {
  const ForYourHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosBloc()
        ..add(
          VideosDisplayed(),
        ),
      child: BlocBuilder<VideosBloc, VideosState>(
        builder: (context, state) {
          if (state is VideosLoading) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 24.h,
                ),
                child: const ShimmerLoading(
                  itemCount: 2,
                ),
              ),
            );
          }

          if (state is VideosLoaded) {
            return _fyhNews(
              state.videos,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _fyhNews(List<VideosModel> videos) {
    return SizedBox(
      height: 330.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return HomeVideosCard(
            videosModel: videos[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 20.w,
          );
        },
      ),
    );
  }
}
