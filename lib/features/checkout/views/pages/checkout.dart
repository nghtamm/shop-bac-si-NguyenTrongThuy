import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/cart_helper.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/widgets/cart_appbar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/order_registration.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/button_state_cubit.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  CheckoutPage({required this.products, super.key});

  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _phoneCon = TextEditingController();
  final TextEditingController _nameCon = TextEditingController();

  Widget _nameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 10.h,
      ),
      child: TextField(
        controller: _nameCon,
        decoration: const InputDecoration(
          hintText: "Nhập họ và tên",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 10.h,
      ),
      child: TextField(
        controller: _addressCon,
        decoration: const InputDecoration(
          hintText: "Nhập địa chỉ giao hàng",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _phoneField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 10.h,
      ),
      child: TextField(
        controller: _phoneCon,
        decoration: const InputDecoration(
          hintText: "Nhập số điện thoại",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CartAppbar(),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
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
              _nameField(context),
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
              _phoneField(context),
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
              _addressField(context),
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
                    context.read<ButtonStateCubit>().execute(
                          usecase: OrderRegistrationUseCase(),
                          params: OrderRegistrationReq(
                            products: products,
                            createdDate: DateTime.now().toString(),
                            itemCount: products.length,
                            totalPrice:
                                CartHelper.calculateCartSubtotal(products),
                            shippingAddress: _addressCon.text,
                            name: _nameCon.text,
                            phoneNumber: _phoneCon.text,
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
}
