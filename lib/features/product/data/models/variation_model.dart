class VariationModel {
  final int id;
  final String name;
  final String price;
  final String? regularPrice;
  final String? salePrice;

  VariationModel({
    required this.id,
    required this.name,
    required this.price,
    this.regularPrice,
    this.salePrice,
  });

  factory VariationModel.fromJson(Map<String, dynamic> json) {
    return VariationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '0',
      regularPrice: json['regular_price'] ?? '0',
      salePrice: json['sale_price'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
    };
  }
}