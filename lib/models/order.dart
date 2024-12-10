import 'dart:convert';

class Order {
  final String userId;
  final List<Product> products;
  final double total;
  final String status;
  final DeliveryLocation deliveryLocation;
  final String id;
  final DateTime creationDate;

  Order({
    required this.userId,
    required this.products,
    required this.total,
    required this.status,
    required this.deliveryLocation,
    required this.id,
    required this.creationDate,
  });

  // Factory constructor para convertir un JSON en una instancia de Order
  factory Order.fromJson(Map<String, dynamic> json) {
     final order = Order(
      userId: json['userId'] as String, // Asegúrate de que 'userId' es un String
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(), // Convierte total a double
      status: json['status'] as String, // Asegúrate de que 'status' es un String
      deliveryLocation: DeliveryLocation.fromJson(json['deliveryLocation'] as Map<String, dynamic>),
      id: json['_id'] as String, // Asegúrate de que '_id' es un String
      creationDate: DateTime.parse(json['creationDate'] as String),
    );
    print(order);
    return order;
  }

  // Método para convertir la instancia de Order a JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'total': total,
      'status': status,
      'deliveryLocation': deliveryLocation.toJson(),
      '_id': id,
      'creationDate': creationDate.toIso8601String(),
    };
  }
}

class Product {
  final String productId;
  final int quantity;
  final String id;

  Product({
    required this.productId,
    required this.quantity,
    required this.id,
  });

  // Factory constructor para convertir un JSON en una instancia de Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as String, // Asegúrate de que 'productId' es un String
      quantity: json['quantity'] as int, // Asegúrate de que 'quantity' es un entero
      id: json['_id'] as String, // Asegúrate de que '_id' es un String
    );
  }

  // Método para convertir la instancia de Product a JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      '_id': id,
    };
  }
}

class DeliveryLocation {
  final double lat;
  final double lng;

  DeliveryLocation({
    required this.lat,
    required this.lng,
  });

  // Factory constructor para convertir un JSON en una instancia de DeliveryLocation
  factory DeliveryLocation.fromJson(Map<String, dynamic> json) {
    return DeliveryLocation(
      lat: (json['lat'] as num).toDouble(), // Convierte latitud a double
      lng: (json['lng'] as num).toDouble(), // Convierte longitud a double
    );
  }

  // Método para convertir la instancia de DeliveryLocation a JSON
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
