class Product {
  final String id, title, imageUrl;
  String description;

  int stock, salesCount;
  double price, rating;

  double totalProductPrice=0;
  static double totalProductsPrice=0;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.stock,
    this.description = 'product description',
    this.rating = 0,
    this.salesCount = 0,
    this.totalProductPrice=0
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'stock': stock,
      'description': description,
      'rating': rating,
      'salesCount': salesCount,
    };
  }

  @override
  String toString() => toJson().toString();

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        title = json['title'] ?? "",
        imageUrl = json['imageUrl'] ?? "",
        price = double.tryParse(json['price'].toString()) ?? 0.0,
        stock = json['stock']??0,
        description = json['description'],
        rating = double.tryParse(json['rating'].toString()) ?? 0.0,
        salesCount = json['salesCount'] ?? 0;
}