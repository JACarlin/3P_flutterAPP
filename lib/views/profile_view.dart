import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  final Map<String, dynamic> userProfile = {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "password": "securepassword123",
    "address": "123 Main Street, City, Country",
    "creationDate": "2024-12-08T02:32:32.941Z",
  };

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Información del Perfil',
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildProfileField('Nombre', userProfile['name']),
              SizedBox(height: 15),
              _buildProfileField('Correo Electrónico', userProfile['email']),
              SizedBox(height: 15),
              _buildProfileField('Contraseña', '*' * userProfile['password'].length),
              SizedBox(height: 15),
              _buildProfileField('Dirección', userProfile['address']),
              SizedBox(height: 15),
              _buildProfileField('Fecha de Creación', _formatDate(userProfile['creationDate'])),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  ),
                  child: Text(
                    'Regresar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
