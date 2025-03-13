import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/cart_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;

  CheckoutPage({
    required this.products,
    super.key,
  });

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => OrdersBloc(),
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 40.w,
                  top: 30.h,
                  bottom: 20.h,
                ),
                child: Text(
                  'THÔNG TIN\nVẬN CHUYỂN',
                  style: AppTypography.black['32_extraBold'],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                ),
                child: Text(
                  'Họ và tên',
                  style: AppTypography.black['20_medium'],
                ),
              ),
              _checkoutInputField(
                context,
                'Nhập họ và tên',
                _nameController,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                ),
                child: Text(
                  'Số điện thoại',
                  style: AppTypography.black['20_medium'],
                ),
              ),
              _checkoutInputField(
                context,
                'Nhập số điện thoại',
                _phoneController,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                ),
                child: Text(
                  'Địa chỉ giao hàng',
                  style: AppTypography.black['20_medium'],
                ),
              ),
              _checkoutInputField(
                context,
                'Nhập địa chỉ giao hàng',
                _addressController,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 40.h,
                  left: 40.w,
                  right: 40.w,
                ),
                child: ElevatedButton(
                  child: Text(
                    'TIẾP TỤC THANH TOÁN',
                    style: AppTypography.white['20_extraBold'],
                  ),
                  onPressed: () {
                    context.read<OrdersBloc>().add(
                          OrderRegistered(
                            requirements: OrderRegistrationReq(
                              products: products,
                              createdDate: DateTime.now().toString(),
                              itemCount: products.length,
                              totalPrice:
                                  CartHelpers.calculateSubtotal(products),
                              shippingAddress: _addressController.text,
                              name: _nameController.text,
                              phoneNumber: _phoneController.text,
                            ),
                          ),
                        );
                    context.push(RoutersName.orderPlaced);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _checkoutInputField(
      BuildContext context, String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 10.h,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
