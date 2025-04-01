import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductModel {
  final int productID; // WooCommerce trả về ID dạng số
  final String title;
  final String description;
  final String shortDescription;
  final List<String> images; // Danh sách URL ảnh
  final String price; // WooCommerce trả về giá dạng chuỗi
  final String? salePrice; // Giá khuyến mãi có thể null

  ProductModel({
    required this.productID,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.price,
    this.salePrice,
  });

  // Chuyển đổi từ Map (dữ liệu trả về từ WooCommerce API) sang ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['id'] as int,
      title: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['short_description'] as String,
      images: json['images'] != null ? List<String>.from(
        json['images'].map((image) => image['src'] as String),
        ) : [],
      price: json['price'] as String,
      salePrice: json['sale_price'] != null ? json['sale_price'] as String : null,
    );
  }

  // Chuyển đổi từ ProductModel sang Map (nếu cần gửi dữ liệu)
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': productID,
      'name': title,
      'description': description,
      'short_description': shortDescription,
      'images': images.map((e) => {'src': e}).toList(),
      'price': price,
      'sale_price': salePrice,
    };
  }
}

extension ProductModelConvert on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      productID: productID.toString(), // Chuyển ID từ số sang chuỗi
      title: title,
      description: description,
      shortDescription: shortDescription,
      images: images,
      price: double.parse(price), // Chuyển giá từ chuỗi sang số
      salesCount: 0, // mặc định là 0, có thể thay đổi sau này
    );
  }
}

extension ProductEntityConvert on ProductEntity {
  ProductModel fromEntity() {
    return ProductModel(
      productID: int.parse(productID),
      title: title,
      description: description,
      shortDescription: shortDescription,
      images: images,
      price: price.toString(),
      salePrice: null,
    );
  }
}
