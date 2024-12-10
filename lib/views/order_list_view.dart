import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/controllers/order_controller.dart';
import 'package:my_ecommerce_app/models/order.dart';
import 'package:provider/provider.dart'; // Importa el paquete Provider

class OrderListView extends StatefulWidget {
  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  @override
  void initState() {
    super.initState();
    // Llamar a fetchOrders cuando la vista se inicializa
    final orderController = Provider.of<OrderController>(context, listen: false);
    orderController.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Órdenes'),
        backgroundColor: Colors.deepPurple, // Color principal Deep Purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OrderController>( // Usamos Consumer para escuchar cambios en OrderController
          builder: (context, orderController, child) {
            if (orderController.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (orderController.errorMessage != null) {
              return Center(child: Text(orderController.errorMessage!));
            }

            return ListView.builder(
              itemCount: orderController.orders.length,
              itemBuilder: (context, index) {
                final order = orderController.orders[index];
                print(order);
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Orden #${order['_id']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: \$${order['total']}'),
                        SizedBox(height: 4),
                        Text(
                          'Estado: ${order['status']}',
                          style: TextStyle(color: _getStatusColor(order['status'])),
                        ),
                        SizedBox(height: 4),
                        Text('Fecha: ${_formatDate(DateTime.parse(order['creationDate']))}'),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/orderDetail', arguments: order);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Método para cambiar el color del estado de la orden
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Shipped':
        return Colors.green;
      case 'Delivered':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Método para formatear la fecha
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
