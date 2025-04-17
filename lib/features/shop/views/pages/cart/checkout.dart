import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/order/orders_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItemModel> products;
  final num shipping;
  late final String shippingMethod;
  late final String shippingTitle;

  CheckoutPage({
    super.key,
    required this.products,
    required this.shipping,
  }) {
    shippingMethod = (shipping == 0) ? 'free_shipping' : 'flat_rate';
    shippingTitle = (shipping == 0) ? 'Giao hàng miễn phí' : 'Phí vận chuyển';
  }

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ValueNotifier<String> _selectedPayment = ValueNotifier<String>('cod');
  final List<Map<String, String>> paymentMethods = [
    {
      'title': 'Thanh toán khi nhận hàng (COD)',
      'method': 'cod',
    },
    {
      'title': 'Chuyển khoản',
      'method': 'casso_up_vietinbank',
    },
  ];

  final TextEditingController _nameController = TextEditingController(
    text: serviceLocator<GlobalStorage>().user?.displayName ?? '',
  );
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(
    text: serviceLocator<GlobalStorage>().user?.email ?? '',
  );
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _emailError;
  String? _phoneError;

  bool get isFormValid =>
      _nameController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _phoneError == null &&
      _emailController.text.trim().isNotEmpty &&
      _emailError == null &&
      _addressController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(
      () => setState(() {}),
    );
    _addressController.addListener(
      () => setState(() {}),
    );
    _noteController.addListener(
      () => setState(() {}),
    );
    _emailController.addListener(
      () => setState(() {
        final email = _emailController.text.trim();

        if (email.isEmpty) {
          _emailError = null;
        } else if (!TextHelpers().validateEmail(email)) {
          _emailError = 'Định dạng email không hợp lệ';
        } else {
          _emailError = null;
        }
      }),
    );
    _phoneController.addListener(
      () => setState(() {
        final phoneNumber = _phoneController.text.trim();

        if (phoneNumber.isEmpty) {
          _phoneError = null;
        } else if (!TextHelpers().validatePhoneNumber(phoneNumber)) {
          _phoneError = 'Số điện thoại phải có 10 chữ số';
        } else {
          _phoneError = null;
        }
      }),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: BlocProvider(
          create: (context) => OrdersBloc(),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        'THÔNG TIN\nVẬN CHUYỂN',
                        style: AppTypography.black['32_extraBold'],
                      ),

                      // Họ và tên
                      SizedBox(height: 20.h),
                      Text(
                        'Họ và tên',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      _checkoutInputField(
                        context,
                        'Nhập họ và tên',
                        _nameController,
                        1,
                      ),

                      // Địa chỉ email
                      SizedBox(height: 10.h),
                      Text(
                        'Địa chỉ email',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      _checkoutInputField(
                        context,
                        'Nhập địa chỉ email',
                        _emailController,
                        1,
                        _emailError,
                      ),

                      // Số điện thoại
                      SizedBox(height: 10.h),
                      Text(
                        'Số điện thoại',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      _checkoutInputField(
                        context,
                        'Nhập số điện thoại',
                        _phoneController,
                        1,
                        _phoneError,
                      ),

                      // Địa chỉ giao hàng
                      SizedBox(height: 10.h),
                      Text(
                        'Địa chỉ giao hàng',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      _checkoutInputField(
                        context,
                        'Nhập địa chỉ giao hàng',
                        _addressController,
                        2,
                      ),

                      // Ghi chú
                      SizedBox(height: 10.h),
                      Text(
                        'Ghi chú (tùy chọn)',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      _checkoutInputField(
                        context,
                        'Ghi chú về đơn hàng. Ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết hơn.',
                        _noteController,
                        6,
                      ),

                      // Phương thức thanh toán
                      SizedBox(height: 10.h),
                      Text(
                        'Phương thức thanh toán',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      SizedBox(height: 2.h),
                      ValueListenableBuilder<String>(
                        valueListenable: _selectedPayment,
                        builder: (context, selected, _) {
                          return Column(
                            children: paymentMethods.map(
                              (method) {
                                return RadioListTile<String>(
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 0.w,
                                  ),
                                  title: method['method'] == 'cod'
                                      ? Text(
                                          'Thanh toán khi nhận hàng',
                                          style:
                                              AppTypography.black['16_medium'],
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              'Chuyển khoản qua',
                                              style: AppTypography
                                                  .black['16_medium'],
                                            ),
                                            SizedBox(width: 6.w),
                                            SvgPicture.asset(
                                              AppAssets.casso,
                                              height: 32.h,
                                            )
                                          ],
                                        ),
                                  value: method['method']!,
                                  groupValue: selected,
                                  onChanged: (value) {
                                    _selectedPayment.value = value!;
                                  },
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),

                      // Checkout
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 40.h,
                        ),
                        child: ElevatedButton(
                          onPressed: isFormValid
                              ? () {
                                  final paymentMethod = _selectedPayment.value;
                                  final paymentTitle =
                                      paymentMethods.firstWhere(
                                    (element) =>
                                        element['method'] == paymentMethod,
                                  )['title'];
                                  final status = paymentMethod == 'cod'
                                      ? 'processing'
                                      : 'on-hold';

                                  final bloc = context.read<OrdersBloc>();
                                  bloc.add(
                                    OrderRegistered(
                                      data: {
                                        "payment_method": paymentMethod,
                                        "payment_method_title": paymentTitle,
                                        "set_paid": false,
                                        "status": status,
                                        "customer_id":
                                            serviceLocator<GlobalStorage>()
                                                .user!
                                                .id,
                                        "customer_note":
                                            _noteController.text.trim(),
                                        "billing": {
                                          "first_name": "",
                                          "last_name":
                                              _nameController.text.trim(),
                                          "address_1":
                                              _addressController.text.trim(),
                                          "address_2": "",
                                          "city": "",
                                          "state": "",
                                          "postcode": "",
                                          "country": "",
                                          "email": _emailController.text.trim(),
                                          "phone": _phoneController.text.trim(),
                                        },
                                        "shipping": {
                                          "first_name": "",
                                          "last_name":
                                              _nameController.text.trim(),
                                          "address_1":
                                              _addressController.text.trim(),
                                          "address_2": "",
                                          "city": "",
                                          "state": "",
                                          "postcode": "",
                                          "country": "",
                                          "email": _emailController.text.trim(),
                                          "phone": _phoneController.text.trim(),
                                        },
                                        "line_items":
                                            widget.products.map((item) {
                                          final map = {
                                            "product_id": item.productID,
                                            "quantity": item.quantity,
                                          };
                                          if (item.optionsID != null) {
                                            map["variation_id"] =
                                                item.optionsID!;
                                          }
                                          return map;
                                        }).toList(),
                                        "shipping_lines": [
                                          {
                                            "method_id": widget.shippingMethod,
                                            "method_title":
                                                widget.shippingTitle,
                                            "total": widget.shipping.toString(),
                                          }
                                        ]
                                      },
                                    ),
                                  );

                                  bloc.stream
                                      .firstWhere(
                                    (state) => state is OrdersLoaded,
                                  )
                                      .then(
                                    (state) {
                                      final successState =
                                          state as OrdersLoaded;

                                      final order = successState.orders.first;
                                      final orderID = order.orderID;
                                      final orderKey = order.orderKey;

                                      if (paymentMethod ==
                                          'casso_up_vietinbank') {
                                        final url =
                                            'https://demo.unclecatvn.com/checkout/order-received/$orderID/?key=$orderKey';
                                        if (context.mounted) {
                                          context.go(
                                            RoutersName.checkoutPayment,
                                            extra: url,
                                          );
                                        }
                                      } else {
                                        if (context.mounted) {
                                          context.go(
                                            RoutersName.orderPlaced,
                                          );
                                        }
                                      }
                                    },
                                  );
                                }
                              : null,
                          child: Text(
                            'TIẾP TỤC THANH TOÁN',
                            style: AppTypography.white['20_extraBold'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _checkoutInputField(
    BuildContext context,
    String hint,
    TextEditingController controller,
    int maxLines, [
    String? error,
  ]) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          errorText: error,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
