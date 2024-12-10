import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_ecommerce_app/services/api_service.dart';
import 'package:my_ecommerce_app/controllers/user_controller.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() {
    // Lógica para redirigir a la pantalla de registro
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicia Sesión'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.login,
                    size: 80,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bienvenido, ingresa a tu cuenta',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Email field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Login Button
                  Consumer<UserController>(
                    builder: (context, loginController, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          // Llamar al método de login del controller
                          await loginController.login(
                            _emailController.text,
                            _passwordController.text,
                          );

                          // Si el login es exitoso, navega
                          if (loginController.errorMessage == null) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            // Si hay error, mostrar mensaje
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loginController.errorMessage!),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(fontSize: 16, color: Colors.grey[50]),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Register Link
                  TextButton(
                    onPressed: _register,
                    child: Text(
                      '¿No tienes cuenta? Regístrate',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
