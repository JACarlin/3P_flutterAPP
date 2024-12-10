import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/main.dart';
import 'package:my_ecommerce_app/controllers/order_controller.dart';
import 'package:my_ecommerce_app/services/api_service.dart';

class CreateOrderView extends StatefulWidget {
  @override
  _CreateOrderViewState createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  List<Map<String, dynamic>> _selectedProducts = [];
  double _total = 0;

  // Método para crear la orden
  void _createOrder() async {
    if (_selectedProducts.isNotEmpty) {
      try {
        // Llamar al controlador para crear la orden
        await OrderController(ApiService()).createOrder();
        
        // Navegar a la vista de órdenes después de crear la orden
        Navigator.pushNamed(context, '/orders');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la orden: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona al menos un producto.')),
      );
    }
  }

  // Método para calcular el total de la orden
  void _calculateTotal() {
    double total = 0;
    for (var product in _selectedProducts) {
      total += product['price'] * product['quantity'];
    }
    setState(() {
      _total = total;
    });
  }

  // Método para alternar la selección de un producto
  void _toggleProductSelection(Map<String, dynamic> product) {
    setState(() {
      if (_selectedProducts.contains(product)) {
        _selectedProducts.remove(product);
      } else {
        _selectedProducts.add(product);
      }
      // Recalcular el total al seleccionar o deseleccionar un producto
      _calculateTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Accede a los productos desde UserSession
    final userData = UserSession().userData;

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
              'Productos en el carrito',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  final product = userData[index];
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
      leading: Image.network(
        product['url'],
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        product['name'],
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Precio unitario: \$${product['price'].toStringAsFixed(2)}'),
          Text('Cantidad: ${product['quantity']}'),
          Text('Total: \$${(product['price'] * product['quantity']).toStringAsFixed(2)}'),
        ],
      ),
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
            Text(
              'Total: \$${_total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createOrder,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text(
                '  Crear Orden  ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
