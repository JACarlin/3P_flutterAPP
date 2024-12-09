import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product.dart';

class ProductListView extends StatelessWidget {
final List<Product> products = [
  Product(
    productId: '1',
    name: 'Producto 1',
    price: 100.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '2',
    name: 'Producto 2',
    price: 200.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '1',
    name: 'Producto 1',
    price: 100.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '2',
    name: 'Producto 2',
    price: 200.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '1',
    name: 'Producto 1',
    price: 100.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '2',
    name: 'Producto 2',
    price: 200.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '1',
    name: 'Producto 1',
    price: 100.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
  Product(
    productId: '2',
    name: 'Producto 2',
    price: 200.0,
    description: 'Descripción del producto',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfwHKYZjup6mJWD1RvR5ZS7VOZeG7Pmkt_g&s',
    category: 'Electronics',
  ),
];


  void _showAdminDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Introduce la clave de administrador'),
          content: TextField(
            controller: _controller,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Clave'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_controller.text == 'admin123') {
                  Navigator.of(context).pop(); // Cierra el diálogo primero
                  Navigator.pushNamed(context, '/admin'); // Luego redirige
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clave incorrecta')),
                  );
                  Navigator.of(context).pop(); // Cierra el diálogo en caso de clave incorrecta
                }
              },
              child: Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Solo cierra el diálogo sin redirigir
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _showCreateOrderDialog(BuildContext context) {
    // Aquí podrías implementar un diálogo o simplemente redirigir
    Navigator.pushNamed(context, '/createOrder');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                // Navegar a la vista de detalle del producto
                Navigator.pushNamed(context, '/productDetail', arguments: product);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.description,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showAdminDialog(context), // Mostrar el diálogo de admin
            child: Icon(Icons.admin_panel_settings),
            backgroundColor: Colors.deepPurple,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _showCreateOrderDialog(context), // Redirigir a la vista de crear orden
            child: Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}