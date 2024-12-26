// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';

class ProductOrderedModel {
  final String productID;
  final String productTitle;
  final num productQuantity;
  final num productPrice;
  final num totalPrice;
  final String productImage;
  final String createdDate;
  final String id;

  ProductOrderedModel(
      {required this.productID,
      required this.productTitle,
      required this.productQuantity,
      required this.productPrice,
      required this.totalPrice,
      required this.productImage,
      required this.createdDate,
      required this.id});

  factory ProductOrderedModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderedModel(
      productID: map['productID'] as String,
      productTitle: map['productTitle'] as String,
      productQuantity: map['productQuantity'] as int,
      productPrice: map['productPrice'] as double,
      totalPrice: map['totalPrice'] as double,
      productImage: map['productImage'] as String,
      createdDate: map['createdDate'] as String,
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'productTitle': productTitle,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'totalPrice': totalPrice,
      'productImage': productImage,
      'createdDate': createdDate,
      'id': id,
    };
  }
}

extension ProductOrderedModelX on ProductOrderedModel {
  ProductOrderedEntity toEntity() {
    return ProductOrderedEntity(
      productID: productID,
      productTitle: productTitle,
      productQuantity: productQuantity,
      productPrice: productPrice,
      totalPrice: totalPrice,
      productImage: productImage,
      createdDate: createdDate,
      id: id,
    );
  }
}

extension ProductOrderedXEntity on ProductOrderedEntity {
  ProductOrderedModel fromEntity() {
    return ProductOrderedModel(
        productID: productID,
        productTitle: productTitle,
        productQuantity: productQuantity,
        productPrice: productPrice,
        totalPrice: totalPrice,
        productImage: productImage,
        createdDate: createdDate,
        id: id);
  }
}
