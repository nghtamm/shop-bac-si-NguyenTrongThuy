import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductModel {
  final String productID;
  final String title;
  final String description;
  final String shortDescription;
  final List<String> images;
  final num price;
  final num salesCount;

  ProductModel({
    required this.productID,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.price,
    required this.salesCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'title': title,
      'description': description,
      'shortDescription': shortDescription,
      'images': images.map((e) => e.toString()).toList(),
      'price': price,
      'salesCount': salesCount,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productID: map['productID'] != null ? map['productID'] as String : '',
      title: map['title'] as String,
      description: map['description'] as String,
      shortDescription: map['shortDescription'] as String,
      images: List<String>.from(
        map['images'].map((e) => e.toString()),
      ),
      price: map['price'] as num,
      salesCount: map['salesCount'] as num,
    );
  }
}

extension ProductModelConvert on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      productID: productID,
      title: title,
      description: description,
      shortDescription: shortDescription,
      images: images.map((e) => e.toString()).toList(),
      price: price,
      salesCount: salesCount,
    );
  }
}

extension ProductEntityConvert on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      productID: productID,
      title: title,
      description: description,
      shortDescription: shortDescription,
      images: images.map((e) => e.toString()).toList(),
      price: price,
      salesCount: salesCount,
    );
  }
}
