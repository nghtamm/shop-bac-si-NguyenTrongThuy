import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/entities/news.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeNewsCard extends StatelessWidget {
  final NewEntity newEntity;

  const HomeNewsCard({
    super.key,
    required this.newEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: InkWell(
            onTap: () async {
              final Uri url = Uri.parse(newEntity.url);
              if (!await launchUrl(url)) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    const MaterialBanner(
                      forceActionsBelow: true,
                      content: AwesomeSnackbarContent(
                        title: 'Đã xảy ra lỗi',
                        message: 'Tin tức bị lỗi hoặc không tồn tại.',
                        contentType: ContentType.failure,
                        inMaterialBanner: true,
                      ),
                      actions: [
                        SizedBox.shrink(),
                      ],
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    }
                  });
                }
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.gray,
                    width: 0.5.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        ImageHelpers.generateNewsImageURL(
                          newEntity.images,
                        ),
                        fit: BoxFit.cover,
                        width: 300.w,
                        height: 180.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              newEntity.title,
                              style: AppTypography.black['16_semiBold'],
                            ),
                          ),
                          SizedBox(width: 20.w),
                          const CircleAvatar(
                            backgroundColor: AppColors.cyanSoft,
                            radius: 20,
                            child: Icon(
                              Icons.healing_rounded,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
