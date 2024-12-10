import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_ecommerce_app/controllers/user_controller.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();

  void _register(UserController userController) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final address = _addressController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || address.isEmpty) {
      _showErrorDialog('Por favor, complete todos los campos.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog('Las contraseñas no coinciden.');
      return;
    }

    try {
      // Llamar al método register del UserController
      await userController.register(name, email, password, address);
      // Navegar a otra pantalla si el registro es exitoso
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      // Mostrar un error si ocurre
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Registro'),
            backgroundColor: Colors.deepPurple,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Crea una cuenta',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nombre',
                      isPassword: false,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Correo electrónico',
                      isPassword: false,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Contraseña',
                      isPassword: true,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirmar Contraseña',
                      isPassword: true,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Dirección',
                      isPassword: false,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _register(userController),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        ),
                        child: Text(
                          'Registrar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
