import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/order/orders_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/order/empty_order_history.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => OrdersBloc()
          ..add(
            DislayOrderHistory(
              customerID: serviceLocator<GlobalStorage>().user!.id ?? '',
            ),
          ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                bottom: 10.h,
                left: 30.w,
                right: 30.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'LỊCH SỬ ĐƠN MUA',
                  style: AppTypography.black['32_extraBold'],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is OrdersLoaded) {
                    return state.orders.isNotEmpty
                        ? _orders(state.orders)
                        : const EmptyOrderHistory();
                  }

                  if (state is OrdersLoadFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orders(List<OrderModel> orders) {
    ({String text, Color color}) getOrderStatus(String status) {
      switch (status) {
        case 'pending':
          return (
            text: 'Đang chờ',
            color: AppColors.gray,
          );
        case 'processing':
          return (
            text: 'Đang xử lý',
            color: Colors.blue,
          );
        case 'on-hold':
          return (
            text: 'Đang chờ giao hàng',
            color: Colors.orange,
          );
        case 'completed':
          return (
            text: 'Hoàn thành',
            color: Colors.green,
          );
        case 'cancelled':
          return (
            text: 'Đã hủy',
            color: AppColors.redSoft,
          );
        case 'failed':
          return (
            text: 'Thất bại',
            color: Colors.red,
          );
        default:
          return (
            text: 'Không xác định',
            color: AppColors.black,
          );
      }
    }

    return Container(
      color: AppColors.grayLight,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final status = getOrderStatus(orders[index].status);

          return GestureDetector(
            onTap: () {
              context.push(
                RoutersName.orderDetails,
                extra: orders[index],
              );
            },
            child: Container(
              height: 110.h,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: CachedNetworkImage(
                            imageUrl: orders[index].lineItems[0].image,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orders[index].lineItems.length == 1
                                    ? orders[index].lineItems[0].name
                                    : '${orders[index].lineItems[0].name} và ${orders[index].lineItems.length - 1} sản phẩm khác',
                                style: AppTypography.black['16_semiBold'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                status.text,
                                style:
                                    AppTypography.black['14_medium']?.copyWith(
                                  color: status.color,
                                ),
                              ),
                              Text(
                                'Ngày tạo: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(orders[index].date))}',
                                style:
                                    AppTypography.black['14_medium']?.copyWith(
                                  color: AppColors.gray,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 16.h,
        ),
        itemCount: orders.length,
      ),
    );
  }
}
