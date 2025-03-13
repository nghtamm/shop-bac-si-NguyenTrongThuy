import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_display_state.dart';
=======
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
>>>>>>> nghtamm2003/refactor

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: AppColors.grayLight,
        elevation: 0,
=======
      appBar: const CustomAppBar(
        backgroundColor: AppColors.grayLight,
>>>>>>> nghtamm2003/refactor
      ),
      body: BlocProvider(
        create: (context) => OrdersBloc()..add(OrdersDisplayed()),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrdersLoaded) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppColors.grayLight,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.h,
                        left: 30.w,
                        right: 30.w,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'LỊCH SỬ ĐƠN HÀNG',
<<<<<<< HEAD
                          style: AppTypography.black['28_bold'],
=======
                          style: AppTypography.black['32_extraBold'],
>>>>>>> nghtamm2003/refactor
                        ),
                      ),
                    ),
                    Expanded(
<<<<<<< HEAD
                      child: _orders(state.orders),
=======
                      child: _orders(
                        state.orders,
                      ),
>>>>>>> nghtamm2003/refactor
                    ),
                  ],
                ),
              );
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
    );
  }

  Widget _orders(List<OrderEntity> orders) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(
              RoutersName.orderDetails,
              extra: orders[index],
            );
          },
          child: Container(
            height: 80.h,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_rounded,
                      size: 30,
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hóa đơn ngày ${orders[index].createdDate.split(' ')[0]}',
                          style: AppTypography.black['16_semiBold'],
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Giá trị đơn hàng: ${orders[index].totalPrice}đ',
                          style: AppTypography.black['14_regular']?.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 20.h,
      ),
      itemCount: orders.length,
    );
  }
}
