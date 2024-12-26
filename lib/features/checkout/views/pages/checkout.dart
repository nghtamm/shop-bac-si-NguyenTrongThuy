import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/cart_helper.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/widgets/cart_appbar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/order_registration.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/button_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/button_state_cubit.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  CheckoutPage({required this.products, super.key});

  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _phoneCon = TextEditingController();
  final TextEditingController _nameCon = TextEditingController();

  Widget _nameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: _phoneCon,
        decoration: const InputDecoration(
          hintText: "Nhập điện thoại",
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
              const Padding(
                padding: EdgeInsets.only(left: 40, top: 30, bottom: 20),
                child: Text(
                  'THÔNG TIN\nVẬN CHUYỂN',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 44.0),
                child: Text(
                  'Họ và tên',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              _nameField(context),
              Padding(
                padding: const EdgeInsets.only(left: 44.0),
                child: Text(
                  'Số điện thoại',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              _phoneField(context),
              Padding(
                padding: const EdgeInsets.only(left: 44.0),
                child: Text(
                  'Địa chỉ giao hàng',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              _addressField(context),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
                child: ElevatedButton(
                  child: const Text(
                    'TIẾP TỤC THANH TOÁN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
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
                        ));
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
