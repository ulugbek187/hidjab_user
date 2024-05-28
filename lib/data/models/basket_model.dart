class BasketModel {
  final String productName;
  final String description;
  final String imageUrl;
  final String images;
  final String categoryName;
  final String uuid;
  final String userId;
  final String modelName;
  final double price;
  final double rate;
  final double allPrice;
  final int countOfProducts;

  BasketModel({
    required this.imageUrl,
    required this.categoryName,
    required this.images,
    required this.description,
    required this.price,
    required this.productName,
    required this.rate,
    required this.modelName,
    required this.allPrice,
    required this.countOfProducts,
    required this.uuid,
    required this.userId,
  });

  BasketModel copyWith({
    String? productName,
    String? description,
    String? imageUrl,
    String? images,
    String? categoryName,
    String? uuid,
    String? userId,
    String? modelName,
    double? price,
    double? rate,
    double? allPrice,
    int? countOfProducts,
  }) =>
      BasketModel(
        imageUrl: imageUrl ?? this.imageUrl,
        categoryName: categoryName ?? this.categoryName,
        images: images ?? this.images,
        description: description ?? this.description,
        price: price ?? this.price,
        productName: productName ?? this.productName,
        rate: rate ?? this.rate,
        modelName: modelName ?? this.modelName,
        allPrice: allPrice ?? this.allPrice,
        countOfProducts: countOfProducts ?? this.countOfProducts,
        uuid: uuid ?? this.uuid,
        userId: userId ?? this.userId,
      );

  factory BasketModel.fromJson(Map<String, dynamic> json) => BasketModel(
        imageUrl: json['image_url'] as String? ?? '',
        categoryName: json['category_name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        price: (json['price'] as num? ?? 0).toDouble(),
        productName: json['product_name'] as String? ?? '',
        modelName: json['model_name'] as String? ?? '',
        rate: (json['rate'] as num? ?? 0).toDouble(),
        images: json['images'] as String? ?? '',
        allPrice: (json['all_price'] as num? ?? 0).toDouble(),
        countOfProducts: json['count_of_product'] as int? ?? 0,
        uuid: json['uuid'] as String? ?? '',
        userId: json['userId'] as String? ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'model_name': modelName,
      'description': description,
      'uuid': uuid,
      'userId': userId,
      'image_url': imageUrl,
      'images': images,
      'category_name': categoryName,
      'price': price,
      'rate': rate,
      'all_price': allPrice,
      'count_of_product': countOfProducts,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'all_price': allPrice,
      'count_of_product': countOfProducts,
    };
  }
}
