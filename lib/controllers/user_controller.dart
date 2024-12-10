import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/services/api_service.dart';
import 'package:my_ecommerce_app/main.dart';  // Importa la clase UserSession

class UserController extends ChangeNotifier {
  final ApiService _apiService;
  String? _errorMessage;

  UserController(this._apiService);

  String? get errorMessage => _errorMessage;

  // Método para realizar el login
  Future<void> login(String email, String password) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      print('Login exitoso, ID del usuario');
      
      // Limpiar las variables dentro de UserSession antes de guardar el userId
      UserSession().userData.clear();
      
      // Guardar el userId en UserSession
      UserSession().userId = response['user']['_id'];
      print('ID de usuario guardado en UserSession: ${UserSession().userId}');
      
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Método para registrar un nuevo usuario
  Future<void> register(String name, String email, String password, String address) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.register(name, email, password, address);
      print(response['_id']); // Extraer el ID del usuario
      print('Registro exitoso, ID del usuario');
      
      // Limpiar las variables dentro de UserSession antes de guardar el userId
      UserSession().userData.clear();
      
      // Guardar el userId en UserSession
      UserSession().userId = response['_id'];
      print(UserSession().userId);
      print('ID de usuario guardado en UserSession: ${UserSession().userId}');
      
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Método para obtener el perfil del usuario
  Future<Map<String, dynamic>> fetchProfile() async {
    
    if (UserSession().userId == null) {
      throw Exception('Usuario no autenticado');
    }

    try {
      final profile = await _apiService.fetchUserProfile(UserSession().userId!);
      print('Perfil obtenido: $profile');
      return profile;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
