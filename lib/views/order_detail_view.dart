import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/views/gMapsHtml.dart'; // Importar GMapsHtml

class OrderDetailView extends StatefulWidget {
  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
  final Map<String, dynamic> order = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;


    // Construir la URL del mapa con las coordenadas de la entrega
    final String mapUrl =
        'https://www.google.com/maps?q=${order["deliveryLocation"]["lat"]},${order["deliveryLocation"]["lng"]}&z=18&output=embed';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la Orden #${order["_id"]}', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Text('Estado: ${order["status"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Total: \$${order["total"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Fecha: ${_formatDate(DateTime.parse(order["creationDate"]))}', style: TextStyle(fontSize: 16)),
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
                    ...order["products"].map<Widget>((product) {
                      final productInfo = product["productId"];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.network(
                                productInfo["url"],
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productInfo["name"],
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text('Precio: \$${productInfo["price"]}'),
                                  Text('Cantidad: ${product["quantity"]}'),
                                  Text('Total: \$${productInfo["price"] * product["quantity"]}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Mapa de la ubicación
            Text('Ubicación del paquete:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: GMapsHtml(url: mapUrl), // Aquí se agrega el mapa usando GMapsHtml
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
