import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';

class OrderModel {
  final List<ProductOrderedModel> products;
  final String createdDate;
  final String shippingAddress;
  final String name;
  final String phoneNumber;
  final num itemCount;
  final num totalPrice;

  OrderModel({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalPrice,
    required this.shippingAddress,
    required this.name,
    required this.phoneNumber,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      products: List<ProductOrderedModel>.from(
        (map['products'].map(
          (e) => ProductOrderedModel.fromMap(e),
        )),
      ),
      createdDate: map['createdDate'] as String,
      shippingAddress: map['shippingAddress'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      itemCount: map['itemCount'] as num,
      totalPrice: map['totalPrice'] as num,
    );
  }
}

extension OrderModelConvert on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      products: products.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      itemCount: itemCount,
      totalPrice: totalPrice,
      shippingAddress: shippingAddress,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
