class ProductEntity {
  final String productID;
  final String title;
  final String description;
  final String shortDescription;
  final List<String> images;
  final num price;
  final num salesCount;

  ProductEntity({
    required this.productID,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.price,
    required this.salesCount,
  });
}
