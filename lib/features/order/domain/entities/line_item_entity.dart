class LineItemEntity {
  final int id;
  final String name;
  final int productID;
  final int variationID;
  final String subtotal;
  final String total;
  final double price;
  final String image;

  LineItemEntity({
    required this.id,
    required this.name,
    required this.productID,
    required this.variationID,
    required this.subtotal,
    required this.total,
    required this.price,
    required this.image,
  });
}
