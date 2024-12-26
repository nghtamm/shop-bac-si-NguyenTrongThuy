// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';

class OrderRegistrationReq {
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final String name;
  final String phoneNumber;
  final num itemCount;
  final num totalPrice;

  OrderRegistrationReq(
      {required this.products,
      required this.createdDate,
      required this.itemCount,
      required this.totalPrice,
      required this.shippingAddress,
      required this.name,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress,
      'name': name,
      'phoneNumber': phoneNumber
    };
  }
}
