import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel orderModel;

  const OrderDetailsPage({
    required this.orderModel,
    super.key,
  });

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 20.h,
            ),
            child: Text(
              'CHI TIẾT\nĐƠN HÀNG',
              style: AppTypography.black['32_extraBold'],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _firstItem(),
                  if (widget.orderModel.lineItems.length > 1) ...[
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMore = !_showMore;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            _showMore
                                ? 'Ẩn bớt sản phẩm'
                                : 'Xem thêm ${widget.orderModel.lineItems.length - 1} sản phẩm khác',
                            style: AppTypography.black['16_regular']?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            _showMore
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    _otherItems(),
                  ],
                  _orderStatusStepper(
                    widget.orderModel.status,
                  ),
                  SizedBox(height: 20.h),
                  _shippingName(),
                  SizedBox(height: 10.h),
                  _shippingAddress(),
                  SizedBox(height: 10.h),
                  _shippingPhone(),
                  SizedBox(height: 10.h),
                  _shippingMethod(),
                  SizedBox(height: 10.h),
                  _shippingTotal(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _shippingTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Tổng tiền: ',
          style: AppTypography.black['18_semiBold'],
        ),
        Text(
          TextHelpers().formatVNCurrency(
            widget.orderModel.total.toString(),
          ),
          style: AppTypography.black['28_extraBold'],
        ),
      ],
    );
  }

  Column _shippingMethod() {
    String getPaymentMethod(String paymentMethod) {
      if (paymentMethod == 'casso_up_vietinbank') {
        return 'Chuyển khoản qua Casso';
      } else if (paymentMethod == 'cod') {
        return 'Thanh toán khi nhận hàng';
      }
      return 'Phương thức thanh toán khác';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phương thức thanh toán: ',
          style: AppTypography.black['18_semiBold'],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            const Icon(
              Icons.local_shipping_outlined,
            ),
            SizedBox(width: 6.w),
            Text(
              getPaymentMethod(widget.orderModel.paymentMethod),
              style: AppTypography.black['18_regular'],
            ),
          ],
        ),
      ],
    );
  }

  Column _shippingPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Số điện thoại',
          style: AppTypography.black['18_semiBold'],
        ),
        SizedBox(height: 5.h),
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: widget.orderModel.shipping.phone,
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.call_rounded,
            ),
          ),
        ),
      ],
    );
  }

  Column _shippingAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Địa chỉ giao hàng',
          style: AppTypography.black['18_semiBold'],
        ),
        SizedBox(height: 5.h),
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: [
              widget.orderModel.shipping.address1,
              if (widget.orderModel.shipping.address2.isNotEmpty)
                widget.orderModel.shipping.address2,
              if (widget.orderModel.shipping.city.isNotEmpty)
                widget.orderModel.shipping.city,
              if (widget.orderModel.shipping.state.isNotEmpty)
                widget.orderModel.shipping.state,
              if (widget.orderModel.shipping.country.isNotEmpty)
                widget.orderModel.shipping.country,
            ].where((element) => element.isNotEmpty).join(', '),
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.home_rounded,
            ),
          ),
        ),
      ],
    );
  }

  Column _shippingName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Họ và tên',
          style: AppTypography.black['18_semiBold'],
        ),
        SizedBox(height: 5.h),
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: widget.orderModel.shipping.lastName,
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person_rounded,
            ),
          ),
        ),
      ],
    );
  }

  Container _orderStatusStepper(String status) {
    final steps = ['pending', 'processing', 'on-hold', 'completed'];
    final stepLabels = {
      'pending': 'Chờ xác nhận',
      'processing': 'Đang xử lý',
      'on-hold': 'Đang chờ giao hàng',
      'completed': 'Hoàn thành',
    };
    final stepIcons = {
      'pending': Icons.schedule_rounded,
      'processing': Icons.inventory_rounded,
      'on-hold': Icons.local_shipping_rounded,
      'completed': Icons.check_rounded,
    };

    final currentStepIndex = steps.indexOf(status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        color: AppColors.grayLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ĐƠN HÀNG SỐ #${widget.orderModel.orderID}',
            style: AppTypography.black['18_semiBold'],
          ),
          SizedBox(height: 15.h),
          ...List.generate(steps.length, (index) {
            final isActive = index <= currentStepIndex;
            final stepColor = isActive ? AppColors.primary : AppColors.black;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: stepColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          stepIcons[steps[index]],
                          size: 24,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    if (index < steps.length - 1)
                      Container(
                        width: 2.w,
                        height: 25.h,
                        color: AppColors.grayNeutral,
                      ),
                  ],
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    stepLabels[steps[index]]!,
                    style: AppTypography.black['16_regular']?.copyWith(
                      color: stepColor,
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Visibility _otherItems() {
    return Visibility(
      visible: _showMore,
      child: Column(
        children: List.generate(
          widget.orderModel.lineItems.length - 1,
          (index) {
            final item = widget.orderModel.lineItems[index + 1];
            return Padding(
              padding: EdgeInsets.only(
                top: 12.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: item.image,
                    height: 110.h,
                    width: 110.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppTypography.black['18_semiBold'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              'Đơn giá: ',
                              style: AppTypography.black['16_regular'],
                            ),
                            Text(
                              TextHelpers().formatVNCurrency(
                                item.price.toString(),
                              ),
                              style: AppTypography.black['16_medium'],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Số lượng: ',
                              style: AppTypography.black['16_regular'],
                            ),
                            Text(
                              item.quantity.toString(),
                              style: AppTypography.black['16_medium'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Row _firstItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: widget.orderModel.lineItems[0].image,
          height: 110.h,
          width: 110.w,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.orderModel.lineItems[0].name,
                style: AppTypography.black['18_semiBold'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    'Đơn giá: ',
                    style: AppTypography.black['16_regular'],
                  ),
                  Text(
                    TextHelpers().formatVNCurrency(
                      widget.orderModel.lineItems[0].price.toString(),
                    ),
                    style: AppTypography.black['16_medium'],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Số lượng: ',
                    style: AppTypography.black['16_regular'],
                  ),
                  Text(
                    widget.orderModel.lineItems[0].quantity.toString(),
                    style: AppTypography.black['16_medium'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
