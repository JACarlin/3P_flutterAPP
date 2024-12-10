import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // URL base de la API
  static const String _baseUrl = 'http://192.168.1.79:3000/api';

  // Función para iniciar sesión
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/users/login');

    // Crear el cuerpo de la solicitud
    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      // Realizar la solicitud POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Indicamos que el cuerpo es JSON
        },
        body: body,
      );

      // Verificar si la solicitud fue exitosa
      if (response.statusCode == 200) {
        // Si es exitoso, decodificar el cuerpo de la respuesta JSON
        return json.decode(response.body);
      } else {
        // Si hubo un error, lanzar una excepción
        throw Exception('Error en la autenticación: ${response.statusCode}');
      }
    } catch (e) {
      // Si ocurre un error de conexión o algo inesperado
      throw Exception('Error de conexión: $e');
    }
  }
  
// Función para registrar un nuevo usuario
  Future<Map<String, dynamic>> register(String name, String email, String password, String address) async {
    final url = Uri.parse('$_baseUrl/users/register');

    // Crear el cuerpo de la solicitud
    final body = json.encode({
      'name': name,
      'email': email,
      'password': password,
      'address': address,
    });

    try {
      // Realizar la solicitud POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Indicamos que el cuerpo es JSON
        },
        body: body,
      );
      return json.decode(response.body);
      // Verificar si la solicitud fue exitosa
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Si hubo un error, lanzar una excepción
        final error = json.decode(response.body)['message'] ?? 'Error desconocido';
        throw Exception('Error en el registro: $error');
      }
    } catch (e) {
      // Si ocurre un error de conexión o algo inesperado
      throw Exception('Error de conexión: $e');
    }
  }
  Future<Map<String, dynamic>> fetchUserProfile(String userId) async {
  final url = Uri.parse('$_baseUrl/users/profile/$userId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el perfil: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
Future<List<dynamic>> fetchProducts() async {
  final url = Uri.parse('$_baseUrl/products/');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Retorna la respuesta como una lista
      return List<dynamic>.from(json.decode(response.body));
    } else {
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
Future<Map<String, dynamic>> updateProduct(String productId, String name, String description, double price, String url, String category) async {
  final String endpoint = '$_baseUrl/products/$productId';  // Endpoint específico para el producto
  final uri = Uri.parse(endpoint);

  // Crear el cuerpo de la solicitud con los nuevos datos
  final body = json.encode({
    'name': name,
    'description': description,
    'price': price,
    'url': url,
    'category': category,
  });

  try {
    // Realizar la solicitud PUT
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json', // Indicamos que el cuerpo es JSON
      },
      body: body,
    );

    // Verificar si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Si es exitoso, decodificar el cuerpo de la respuesta JSON
      return json.decode(response.body);
    } else {
      // Si hubo un error, lanzar una excepción
      throw Exception('Error al actualizar el producto: ${response.statusCode}');
    }
  } catch (e) {
    // Si ocurre un error de conexión o algo inesperado
    throw Exception('Error de conexión: $e');
  }
}
Future<Map<String, dynamic>> addProduct(String name, String description, double price, String url, String category) async {
  final String endpoint = '$_baseUrl/products/';  // Endpoint para agregar un nuevo producto
  final uri = Uri.parse(endpoint);

  // Crear el cuerpo de la solicitud con los datos del nuevo producto
  final body = json.encode({
    'name': name,
    'description': description,
    'price': price,
    'url': url,
    'category': category,
  });

  try {
    // Realizar la solicitud POST
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Indicamos que el cuerpo es JSON
      },
      body: body,
    );

    // Verificar si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Si es exitoso, decodificar el cuerpo de la respuesta JSON
      return json.decode(response.body);
    } else {
      // Si hubo un error, lanzar una excepción
      throw Exception('Error al agregar el producto: ${response.statusCode}');
    }
  } catch (e) {
    // Si ocurre un error de conexión o algo inesperado
    throw Exception('Error de conexión: $e');
  }
}


  Future<Map<String, dynamic>> deleteProduct(String productId) async {
  final url = Uri.parse('$_baseUrl/products/$productId');

  try {
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el perfil: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
 Future<void> createOrder({
    required String userId,
    required List<Map<String, dynamic>> products,
    required double total,
    required Map<String, double> deliveryLocation,
  }) async {
    final url = Uri.parse('$_baseUrl/orders/');
    final body = jsonEncode({
      "userId": userId,
      "products": products,
      "total": total,
      "deliveryLocation": deliveryLocation,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print("Orden creada exitosamente");
      } else {
        print("Error al crear orden: ${response.statusCode} ${response.body}");
        throw Exception("Failed to create order");
      }
    } catch (e) {
      print("Error en createOrder: $e");
      throw e;
    }
  }

  // Función para obtener órdenes de un usuario
  Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final url = Uri.parse('$_baseUrl/orders/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((order) => order as Map<String, dynamic>).toList();
      } else {
        print("Error al obtener órdenes: ${response.statusCode} ${response.body}");
        throw Exception("Failed to fetch orders");
      }
    } catch (e) {
      print("Error en getOrders: $e");
      throw e;
    }
  }

}
