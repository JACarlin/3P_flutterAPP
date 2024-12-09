import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/order.dart';
import 'package:my_ecommerce_app/views/gMapsHtml.dart'; // Importar GMapsHtml

class OrderDetailView extends StatefulWidget {
  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
    // Supongamos que la orden tiene una ubicación con latitud y longitud
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;

    // Construir la URL del mapa con las coordenadas de la entrega
    final String mapUrl = 'https://www.google.com/maps?q=${order.deliveryLocation.lat},${order.deliveryLocation.lng}&z=18&output=embed';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la Orden #${order.orderId}', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple, // Color principal
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // Detalles de la Orden (Card con elevación)
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Estado: ${order.status}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Total: \$${order.total}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Fecha: ${_formatDate(order.creationDate)}', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Productos (Card con elevación)
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Productos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ...order.products.map((product) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'ID: ${product.productId}, Cantidad: ${product.quantity}',
                            style: TextStyle(fontSize: 16),
                          ),
                        )).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Mapa de la ubicación
            Text('Ubicación de entrega:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: GMapsHtml(url: mapUrl),  // Aquí se agrega el mapa usando GMapsHtml
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Método para formatear la fecha
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
