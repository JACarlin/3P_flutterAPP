import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido a la Tienda'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón Ver Productos
                Container(
                  width: 200, // Definir el tamaño fijo
                  height: 200, // Asegurar que el botón sea cuadrado
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/products'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                      ),
                      padding: EdgeInsets.zero, // Eliminar padding para ajustar el tamaño
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: 60, // Aumentar el tamaño del icono
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Ver Productos',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Botón Mis Órdenes
                Container(
                  width: 200, // Definir el tamaño fijo
                  height: 200, // Asegurar que el botón sea cuadrado
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/orders'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                      ),
                      padding: EdgeInsets.zero, // Eliminar padding para ajustar el tamaño
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_turned_in,
                          size: 60, // Aumentar el tamaño del icono
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mis Órdenes',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Botón Ver Perfil
                Container(
                  width: 200, // Definir el tamaño fijo
                  height: 200, // Asegurar que el botón sea cuadrado
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700]!,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                      ),
                      padding: EdgeInsets.zero, // Eliminar padding para ajustar el tamaño
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 60, // Aumentar el tamaño del icono
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Ver Perfil',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
