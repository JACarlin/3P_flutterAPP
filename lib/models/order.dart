class Order {
  final String orderId;
  final String userId;
  final List<ProductOrder> products; // Lista de productos en la orden
  final double total;
  final String status;
  final DeliveryLocation deliveryLocation;
  final DateTime creationDate;

  Order({
    required this.orderId,
    required this.userId,
    required this.products,
    required this.total,
    required this.status,
    required this.deliveryLocation,
    required this.creationDate,
  });

  // Método para convertir el modelo de orden a un mapa (para envío en API)
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'products': products.map((e) => e.toJson()).toList(),
      'total': total,
      'status': status,
      'deliveryLocation': deliveryLocation.toJson(),
      'creationDate': creationDate.toIso8601String(),
    };
  }

  // Método para crear un objeto de orden desde un mapa (para recibir desde la API)
  factory Order.fromJson(Map<String, dynamic> json) {
    var productsList = (json['products'] as List)
        .map((productJson) => ProductOrder.fromJson(productJson))
        .toList();
    var deliveryLocation = DeliveryLocation.fromJson(json['deliveryLocation']);
    return Order(
      orderId: json['_id'],
      userId: json['userId'],
      products: productsList,
      total: json['total'],
      status: json['status'],
      deliveryLocation: deliveryLocation,
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}

class ProductOrder {
  final String productId;
  final int quantity;
  final String productOrderId;

  ProductOrder({
    required this.productId,
    required this.quantity,
    required this.productOrderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      '_id': productOrderId,
    };
  }

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      productId: json['productId'],
      quantity: json['quantity'],
      productOrderId: json['_id'],
    );
  }
}

class DeliveryLocation {
  final double lat;
  final double lng;

  DeliveryLocation({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory DeliveryLocation.fromJson(Map<String, dynamic> json) {
    return DeliveryLocation(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
