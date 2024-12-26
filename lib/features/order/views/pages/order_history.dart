import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/app_navigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_detail.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F1F2),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => OrdersDisplayCubit()..displayOrders(),
        child: BlocBuilder<OrdersDisplayCubit, OrdersDisplayState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrdersLoaded) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F2),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        left: 30,
                        right: 30,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'LỊCH SỬ ĐƠN HÀNG',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: _orders(state.orders)),
                  ],
                ),
              );
            }
            if (state is OrdersLoadFailed) {
              return Center(
                child: Text(state.errorMessage),
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
            AppNavigator.push(
              context,
              OrderDetailPage(orderEntity: orders[index]),
            );
          },
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
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
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hóa đơn ngày ${orders[index].createdDate.split(' ')[0]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Giá trị đơn hàng: ${orders[index].totalPrice}đ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: orders.length,
    );
  }
}
