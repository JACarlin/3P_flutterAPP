class Product {
  String productId;
  String name;
  double price;
  String description;
  String url; // Cambié url por url
  String category;

  Product({
    required this.productId,
    required this.name,
    required this.price,
    required this.description,
    required this.url, // Cambié url por url
    required this.category,
  });

  // Método para convertir el modelo de producto a un mapa (para envío en API)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'description': description,
      'url': url, // Cambié url por url
      'category': category,
    };
  }

  // Método para crear un objeto de producto desde un mapa (para recibir desde la API)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['_id'] ?? '', // Valor predeterminado en caso de nulo
      name: json['name'] ?? '',
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'],
      description: json['description'] ?? '',
      url: json['url'] ?? '', // Cambié url por url
      category: json['category'] ?? '',
    );
  }
}
