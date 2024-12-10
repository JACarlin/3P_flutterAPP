import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/services/api_service.dart';
import 'package:my_ecommerce_app/models/product.dart';
import 'package:my_ecommerce_app/main.dart'; 
import 'dart:math';

class OrderController extends ChangeNotifier {
  final ApiService _apiService;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  OrderController(this._apiService);

  List<Map<String, dynamic>> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Obtener órdenes por userId
  Future<void> fetchOrders() async {
    print(UserSession().userId);
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    

    try {
      _orders = await _apiService.getOrders(UserSession().userId!);
    } catch (e) {
      _errorMessage = "Error al obtener las órdenes: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> createOrder() async {
    // Obtener los datos de UserSession
    final userId = UserSession().userId;
    final userData = UserSession().userData;

    // Preparar lista de productos
    final products = userData.map((product) {
      return {
        "productId": product['id'],
        "quantity": product['quantity'],
      };
    }).toList();

    // Calcular el total
    final total = userData.fold(0.0, (sum, product) {
      return sum + (product['price'] * product['quantity']);
    });

  final random = Random();

  // Rango de latitudes y longitudes (aproximadamente alrededor de Roma, Italia)
  final minLat = 41.0;
  final maxLat = 42.0;
  final minLng = 12.0;
  final maxLng = 13.0;

  // Generar valores aleatorios dentro del rango
  double lat = minLat + random.nextDouble() * (maxLat - minLat);
  double lng = minLng + random.nextDouble() * (maxLng - minLng);

    // Coordenadas de entrega hardcodeadas
    final deliveryLocation = {
      "lat": lat,
      "lng": lng,
    };

    try {
      // Llamar al método del servicio
      await _apiService.createOrder(
        userId: userId!,
        products: products,
        total: total,
        deliveryLocation: deliveryLocation,
      );
      print("Orden enviada exitosamente");
            UserSession().userData.clear();
    } catch (e) {
      print("Error al crear la orden: $e");
      rethrow;
    }
  }
}
