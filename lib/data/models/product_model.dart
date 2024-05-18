class ProductModel {
  final String productName;
  final String description;
  final String imageUrl;
  final String images;
  final String categoryName;
  final String globalCategory;
  final String modelName;
  final double price;
  final double rate;
  final int countOfOrders;

  ProductModel({
    required this.imageUrl,
    required this.categoryName,
    required this.countOfOrders,
    required this.images,
    required this.description,
    required this.price,
    required this.productName,
    required this.rate,
    required this.modelName,
    required this.globalCategory,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        imageUrl: json['image_url'] as String? ?? '',
        categoryName: json['category_name'] as String? ?? '',
        countOfOrders: (json['count_of_orders'] as num? ?? 0).toInt(),
        description: json['description'] as String? ?? '',
        price: (json['price'] as num? ?? 0).toDouble(),
        productName: json['product_name'] as String? ?? '',
        modelName: json['model_name'] as String? ?? '',
        rate: (json['rate'] as num? ?? 0).toDouble(),
        images: json['images'] as String? ?? '',
        globalCategory: json['global_category'] as String? ?? '',
      );
}
