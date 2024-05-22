// class ProductModel {
//   final String productName;
//   final String description;
//   final String imageUrl;
//   final String images;
//   final String categoryName;
//   final String globalCategory;
//   final String modelName;
//   final double price;
//   final double rate;
//   final int countOfOrders;
//
//   ProductModel({
//     required this.imageUrl,
//     required this.categoryName,
//     required this.countOfOrders,
//     required this.images,
//     required this.description,
//     required this.price,
//     required this.productName,
//     required this.rate,
//     required this.modelName,
//     required this.globalCategory,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         imageUrl: json['image_url'] as String? ?? '',
//         categoryName: json['category_name'] as String? ?? '',
//         countOfOrders: (json['count_of_orders'] as num? ?? 0).toInt(),
//         description: json['description'] as String? ?? '',
//         price: (json['price'] as num? ?? 0).toDouble(),
//         productName: json['product_name'] as String? ?? '',
//         modelName: json['model_name'] as String? ?? '',
//         rate: (json['rate'] as num? ?? 0).toDouble(),
//         images: json['images'] as String? ?? '',
//         globalCategory: json['global_category'] as String? ?? '',
//       );
// }

class ProductModel {
  final String docId;
  final String productName;
  final String rate;
  final String bookDescription;
  final double price;
  final String imageUrl;
  final String categoryId;

  ProductModel({
    required this.price,
    required this.imageUrl,
    required this.productName,
    required this.docId,
    required this.bookDescription,
    required this.categoryId,
    required this.rate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      docId: json["doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      productName: json["product_name"] as String? ?? "",
      bookDescription: json["product_description"] as String? ?? "",
      price: json["price"] as double? ?? 0.0,
      rate: json["rate"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "image_url": imageUrl,
      "product_name": productName,
      "product_description": bookDescription,
      "price": price,
      "category_id": categoryId,
      "rate": rate,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "image_url": imageUrl,
      "product_name": productName,
      "product_description": bookDescription,
      "price": price,
      "category_id": categoryId,
      "rate": rate,
    };
  }
}

