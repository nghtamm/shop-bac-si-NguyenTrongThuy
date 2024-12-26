import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';

class OrderEntity {
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final String name;
  final String phoneNumber;
  final num itemCount;
  final num totalPrice;

  OrderEntity({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalPrice,
    required this.shippingAddress,
    required this.name,
    required this.phoneNumber,
  });
}
