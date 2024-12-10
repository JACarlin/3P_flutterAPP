import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product.dart';
import 'package:my_ecommerce_app/controllers/product_controller.dart';
import 'package:provider/provider.dart'; // Importar provider

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
    // Llamamos a fetchProducts cuando la pantalla se cargue
    Future.delayed(Duration.zero, () {
      Provider.of<ProductController>(context, listen: false).fetchProducts();
    });
  }

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
        child: Consumer<ProductController>(
          builder: (context, productController, child) {
            // Verifica si hay un error y lo muestra
            if (productController.errorMessage != null) {
              return Center(
                child: Text('Error: ${productController.errorMessage}'),
              );
            }

            // Muestra un indicador de carga si la lista está vacía
            if (productController.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            // Si la lista de productos está vacía
            if (productController.products.isEmpty) {
              return Center(child: Text('No hay productos disponibles.'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                final product = productController.products[index];
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
              product.url, // Cambié url por url
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
