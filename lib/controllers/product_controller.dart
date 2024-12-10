import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product.dart';
import 'package:my_ecommerce_app/services/api_service.dart';
import 'package:my_ecommerce_app/main.dart';

class ProductController extends ChangeNotifier {
  final ApiService _apiService;
  String? _errorMessage;
  List<Product> _products = []; // Lista de productos de tipo Product
  bool _isLoading = false; // Propiedad para el estado de carga

  ProductController(this._apiService);

  String? get errorMessage => _errorMessage;
  List<Product> get products => _products; // Lista de productos de tipo Product
  bool get isLoading => _isLoading; // Getter para isLoading

  // Método para obtener todos los productos
  Future<void> fetchProducts() async {
    _isLoading = true; // Comienza el estado de carga
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.fetchProducts();
      // Convertimos la respuesta (que debería ser una lista de productos en formato JSON)
      _products = (response as List).map((json) => Product.fromJson(json)).toList();
      print('Productos obtenidos');
    } catch (e) {
      _errorMessage = e.toString();
      print('Error al obtener productos: $_errorMessage');
    } finally {
      _isLoading = false; // Finaliza el estado de carga
      notifyListeners();
    }
  }

  /*
  // Método para obtener un producto específico por ID
  Future<Product> fetchProductById(String productId) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.fetchProductById(productId);
      print('Producto obtenido: $response');
      return Product.fromJson(response);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Método para agregar un nuevo producto
  Future<void> addProduct(String name, String description, String price, String url, String category) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.addProduct(name, description, price, url, category);
      print('Producto agregado exitosamente: $response');
      fetchProducts(); // Actualiza la lista de productos después de agregar uno nuevo
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
*/
  // Método para actualizar un producto existente
  Future<void> updateProduct(Product product) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.updateProduct(product.productId, product.name, product.description, product.price, product.url, product.category);
      print('Producto actualizado exitosamente: $response');
      fetchProducts(); // Actualiza la lista de productos después de la actualización
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
Future<void> addProduct(String name, String description, double price, String url, String category) async {
  _errorMessage = null;
  notifyListeners();

  try {
    // Llamada al servicio API para agregar el producto
    final response = await _apiService.addProduct(name, description, price, url, category);
    print('Producto registrado exitosamente: $response');
    fetchProducts(); // Actualiza la lista de productos después de la actualización
  } catch (e) {
    _errorMessage = e.toString();
    notifyListeners();
  }
}
Future<void> addProductToCart(String id, String name, String description, double price, String url, String category) async {
  try {
    // Verificar si el producto ya existe en el carrito
    final existingProduct = UserSession().userData.firstWhere(
      (product) => product['id'] == id,
      orElse: () => null, // Devuelve null si no encuentra el producto
    );

    if (existingProduct != null) {
      // Si el producto ya existe, incrementa la cantidad
      existingProduct['quantity'] = (existingProduct['quantity'] ?? 1) + 1;
    } else {
      // Si el producto no existe, agrégalo con cantidad inicial de 1
      UserSession().userData.add({
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'url': url,
        'category': category,
        'quantity': 1,
      });
    }

    print('Producto agregado o actualizado en el carrito: ${UserSession().userData}');
  } catch (e) {
    _errorMessage = e.toString();
    notifyListeners();
  }
}



  // Método para eliminar un producto
  Future<void> deleteProduct(String productId) async {
    _errorMessage = null;
    notifyListeners();
    //print(productId);
    try {
      final response = await _apiService.deleteProduct(productId);
      print('Producto eliminado exitosamente: $response');
      fetchProducts(); // Actualiza la lista de productos después de eliminar uno
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
