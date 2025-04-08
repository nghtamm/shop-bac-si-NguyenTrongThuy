class ProductModel {
  final int productID;
  // final int itemID;
  final String title;
  final String permalink;
  final String description;
  final String shortDescription;
  final List<String> images;
  final String price;
  final String? regularPrice;
  final String? salePrice;
  final List<String> options;
  final List<int> optionsID;
  final List<int> relatedProducts;

  ProductModel({
    required this.productID,
    // required this.itemID,
    required this.title,
    required this.permalink,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.price,
    this.regularPrice,
    this.salePrice,
    required this.options,
    required this.optionsID,
    required this.relatedProducts,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['id'] ?? 0,
      // itemID: json['item_id'] ?? 0,
      title: json['name'] ?? '',
      permalink: json['permalink'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      images: json['images'] != null
          ? List<String>.from(
              json['images'].map(
                (image) => image['src'] as String,
              ),
            )
          : [],
      price: json['price'] ?? '0',
      regularPrice: json['regular_price'] ?? '0',
      salePrice: json['sale_price'] ?? '0',
      options: json['attributes'] != null
          ? List<String>.from(
              (json['attributes'] as List)
                  .map(
                    (attribute) => attribute['options'] as List?,
                  )
                  .expand(
                    (option) => option ?? [],
                  )
                  .cast<String>(),
            )
          : [],
      optionsID:
          json['variations'] != null ? List<int>.from(json['variations']) : [],
      relatedProducts: json['related_ids'] != null
          ? List<int>.from(json['related_ids'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': productID,
      // 'item_id' : itemID,
      'name': title,
      'permalink': permalink,
      'description': description,
      'short_description': shortDescription,
      'images': images.map((e) => {'src': e}).toList(),
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'attributes': [
        {
          'options': options,
        }
      ],
      'variations': optionsID,
      'related_ids': relatedProducts,
    };
  }
}
