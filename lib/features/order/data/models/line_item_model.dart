class LineItemModel {
  final int id;
  final String name;
  final int productID;
  final int variationID;
  final int quantity;
  final String subtotal;
  final String total;
  final double price;
  final String image;

  LineItemModel({
    required this.id,
    required this.name,
    required this.productID,
    required this.variationID,
    required this.quantity,
    required this.subtotal,
    required this.total,
    required this.price,
    required this.image,
  });

  factory LineItemModel.fromJson(Map<String, dynamic> json) {
    return LineItemModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      productID: json['product_id'] ?? 0,
      variationID: json['variation_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      subtotal: json['subtotal'] ?? '0',
      total: json['total'] ?? '0',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: (json['image'] != null && json['image'] is Map<String, dynamic>)
          ? (json['image']['src'] ?? '')
          : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'product_id': productID,
      'variation_id': variationID,
      'quantity': quantity,
      'subtotal': subtotal,
      'total': total,
      'price': price,
      'image': image,
    };
  }
}
