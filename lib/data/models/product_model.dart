class ProductModel {
  final String docId;
  final String userId;
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
    required this.userId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      docId: json["doc_id"] as String? ?? "",
      userId: json["user_id"] as String? ?? "",
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
      "doc_id": docId,
      "user_id": userId,
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

  static ProductModel initial() => ProductModel(
        price: 0,
        imageUrl: '',
        productName: '',
        docId: '',
        bookDescription: '',
        categoryId: '',
        rate: '',
        userId: '',
      );

  ProductModel copyWith({
    String? docId,
    String? userId,
    String? productName,
    String? rate,
    String? bookDescription,
    double? price,
    String? imageUrl,
    String? categoryId,
  }) {
    return ProductModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      productName: productName ?? this.productName,
      rate: rate ?? this.rate,
      bookDescription: bookDescription ?? this.bookDescription,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
