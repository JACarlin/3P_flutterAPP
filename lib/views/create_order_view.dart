import 'package:flutter/material.dart';

class CreateOrderView extends StatefulWidget {
  @override
  _CreateOrderViewState createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Producto 1',
      'price': 100.0,
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Producto 2',
      'price': 200.0,
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Producto 3',
      'price': 150.0,
      'image': 'https://via.placeholder.com/150'
    },
  ];

  List<Map<String, dynamic>> _selectedProducts = [];

  void _createOrder() {
    if (_selectedProducts.isNotEmpty) {
      // Lógica para crear la orden
      // Navegar a la vista de mis órdenes
      Navigator.pushNamed(context, '/orders');
    } else {
      // Mostrar un mensaje de error si no se seleccionaron productos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona al menos un producto.')),
      );
    }
  }

  void _toggleProductSelection(Map<String, dynamic> product) {
    setState(() {
      if (_selectedProducts.contains(product)) {
        _selectedProducts.remove(product);
      } else {
        _selectedProducts.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Orden'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productos disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final isSelected = _selectedProducts.contains(product);

                  return GestureDetector(
                    onTap: () => _toggleProductSelection(product),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(product['image'], width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(
                          product['name'],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
                        trailing: Icon(
                          isSelected ? Icons.check_circle : Icons.check_circle_outline,
                          color: isSelected ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createOrder,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20), // Hacer el botón más grande
                backgroundColor: Colors.deepPurple, // Usar backgroundColor en lugar de primary
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: 20), // Aumentar el tamaño del texto
              ),
              child: Text('Crear Orden', style: TextStyle(color: Colors.white)), // Texto blanco
            ),
          ],
        ),
      ),
    );
  }
}
