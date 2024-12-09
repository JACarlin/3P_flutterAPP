import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product.dart';

class ProductDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recuperar el objeto Product pasado como argumento
    final product = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto (placeholder si no hay URL)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: product.imageUrl.isNotEmpty
                      ? Image.network(
                          product.imageUrl,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 100,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              // Nombre del producto
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Precio del producto
              Text(
                '\$${product.price}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Categoría
              Text(
                'Categoría: ${product.category}',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              // Descripción del producto
              Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 30),
              // Botón de agregar al carrito
Center(
  child: ElevatedButton.icon(
    onPressed: () {
      // Acción al agregar al carrito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} añadido al carrito'),
          duration: Duration(seconds: 2),
        ),
      );
    },
    icon: Icon(
      Icons.shopping_cart,
      color: Colors.white, // Cambiar el color del ícono aquí
    ),
    label: Text(
      'Agregar al Carrito',
      style: TextStyle(color: Colors.white), // Cambiar el color del texto aquí
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
  ),
),


            ],
          ),
        ),
      ),
    );
  }
}
