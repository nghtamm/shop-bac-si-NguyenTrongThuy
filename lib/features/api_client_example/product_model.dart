class ProductModel {
  final String name;
  final String permalink;
  final String price;

  ProductModel({
    required this.name,
    required this.permalink,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      permalink: json['permalink'] ?? '',
      price: json['price'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'permalink': permalink,
      'price': price,
    };
  }
}
