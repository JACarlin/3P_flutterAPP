import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/order.dart';

class OrderListView extends StatelessWidget {
  final List<Order> orders = [
    Order(
      orderId: '67550c5a4469796054a52212',
      userId: '675505402cf7d29540668525',
      products: [
        ProductOrder(productId: '6755061e2cf7d29540668529', quantity: 2, productOrderId: '67550c5a4469796054a52213'),
        ProductOrder(productId: '675507872cf7d29540668535', quantity: 1, productOrderId: '67550c5a4469796054a52214'),
      ],
      total: 4000,
      status: 'Pending',
      deliveryLocation: DeliveryLocation(lat: 41.903055555556, lng: 12.454444444444),
      creationDate: DateTime.parse('2024-12-08T03:02:50.976Z'),
    ),
    // Agrega más órdenes aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Órdenes'),
        backgroundColor: Colors.deepPurple, // Color principal Deep Purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Orden #${order.orderId}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total: \$${order.total}'),
                    SizedBox(height: 4),
                    Text(
                      'Estado: ${order.status}',
                      style: TextStyle(color: _getStatusColor(order.status)),
                    ),
                    SizedBox(height: 4),
                    Text('Fecha: ${_formatDate(order.creationDate)}'),
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
